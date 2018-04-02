# Changing to not using an .app bundle is a bit tricky. I need to use
# Xcode.
_DEBUG=yes

if [[ ${_DEBUG} == yes ]]; then
  # BUILD_TYPE=RelWithDebInfo
  BUILD_TYPE=Debug
  RSTUDIO_TARGET=Server
  # BUILD_TYPE=RelWithDebInfo
  BUILD_TYPE=Debug
  RSTUDIO_TARGET=Server
  #
  # -Og is removing too much debug info. The callstack that leads to the correct termination on Linux is:
  #
  # (where we land at SessionClientEvent.cpp:
  #              case client_events::kConsoleWriteError:
  #                 return "console_error";
  #
  # 1  rstudio::session::ClientEvent::typeName[abi:cxx11]() const                                                                                                                                            SessionClientEvent.cpp        518  0x55f504d2fef3
  # 2  rstudio::session::ClientEvent::asJsonObject                                                                                                                                                           SessionClientEvent.cpp        201  0x55f504d31933
  # 3  rstudio::session::ClientEventService::run                                                                                                                                                             SessionClientEventService.cpp 332  0x55f504d40d82
  # 4  boost::_mfi::mf0<void, rstudio::session::ClientEventService>::operator()                                                                                                                              mem_fn_template.hpp           49   0x55f504d41935
  # 5  boost::_bi::list1<boost::_bi::value<rstudio::session::ClientEventService *>>::operator()<boost::_mfi::mf0<void, rstudio::session::ClientEventService>, boost::_bi::list0>                             bind.hpp                      259  0x55f504d41935
  # 6  boost::_bi::bind_t<void, boost::_mfi::mf0<void, rstudio::session::ClientEventService>, boost::_bi::list1<boost::_bi::value<rstudio::session::ClientEventService *>>>::operator()                      bind.hpp                      1294 0x55f504d41935
  # 7  boost::detail::thread_data<boost::_bi::bind_t<void, boost::_mfi::mf0<void, rstudio::session::ClientEventService>, boost::_bi::list1<boost::_bi::value<rstudio::session::ClientEventService *>>>>::run thread.hpp                    116  0x55f504d41935
  # 8  thread_proxy                                                                                                                                                                                                                             0x55f50557b72e
  # 9  start_thread                                                                                                                                                                                          pthread_create.c              465  0x7fb0f3d6c7fc
  # 10 clone                                                                                                                                                                                                 clone.S                       95   0x7fb0f2590b5f
  export CFLAGS="${DEBUG_CFLAGS} -O0"
  export CXXFLAGS="${DEBUG_CXXFLAGS} -O0"
else
  BUILD_TYPE=Release
  RSTUDIO_TARGET=Desktop
fi
_XCODE_BUILD=no

# Boost 1.65.1 cannot be used with -std=c++17 it seems. -std=c++14 works.
re='(.*[[:space:]])\-std\=[^[:space:]]*(.*)'
if [[ "${CXXFLAGS}" =~ $re ]]; then
  export CXXFLAGS="${BASH_REMATCH[1]} -std=c++14 ${BASH_REMATCH[2]}"
fi

if [[ ${_XCODE_BUILD} == yes ]]; then
  export LD=$CXX
  # https://stackoverflow.com/q/15761583
  # https://forums.developer.apple.com/thread/17757
  export LDFLAGS="${LDFLAGS} -Xlinker -U -Xlinker _objc_readClassPair"
fi

export RSTUDIO_VERSION_MAJOR=$(echo ${PKG_VERSION} | cut -d. -f1)
export RSTUDIO_VERSION_MINOR=$(echo ${PKG_VERSION} | cut -d. -f2)
export RSTUDIO_VERSION_PATCH=$(echo ${PKG_VERSION} | cut -d. -f3)

pushd dependencies/common
  ./install-gwt
  ./install-dictionaries
  ./install-mathjax
# ./install-boost
# ./install-pandoc
  ./install-libclang
  ./install-packages
popd

if [[ ${target_platform} == osx-64 ]]; then
  for SHARED_LIB in $(find . -type f -iname "libclang.dylib"); do
    $INSTALL_NAME_TOOL -change /usr/lib/libc++.1.dylib "$PREFIX"/lib/libc++.1.dylib ${SHARED_LIB}
    # We may want to whitelist some of these instead?
    $INSTALL_NAME_TOOL -change /usr/lib/libz.1.dylib "$PREFIX"/lib/libz.1.dylib ${SHARED_LIB}
    # libncurses cannot be modified as there is not enough space:
    # changing install names or rpaths can't be redone for: ./dependencies/common/libclang/3.5/libclang.dylib (for architecture x86_64)
    # because larger updated load commands do not fit (the program must be relinked, and you may need to use -headerpad or -headerpad_max_install_names
    # $INSTALL_NAME_TOOL -change /usr/lib/libncurses.5.4.dylib "$PREFIX"/lib/libncursesw.6.dylib ${SHARED_LIB}
    $INSTALL_NAME_TOOL -change /usr/lib/libedit.3.dylib "$PREFIX"/lib/libedit.0.dylib ${SHARED_LIB}
  done
fi

# Out-of-source-tree builds make debugging really difficult:
# https://github.com/rstudio/rstudio/wiki/RStudio-Development
# rm -rf build || true
# mkdir build || true
# cd build

if ! which javac; then
  echo "Fatal: Please install javac with your system package manager"
  exit 1
fi

if ! which ant; then
  echo "Fatal: Please install ant with your system package manager"
  exit 1
fi

export BOOST_ROOT=${PREFIX}

_VERBOSE="VERBOSE=1"

declare -a _CMAKE_EXTRA_CONFIG
if [[ ${HOST} =~ .*darwin.* ]]; then
  if [[ ${_XCODE_BUILD} == yes ]]; then
    _CMAKE_EXTRA_CONFIG+=(-G'Xcode')
    _CMAKE_EXTRA_CONFIG+=(-DCMAKE_OSX_ARCHITECTURES=x86_64)
    _CMAKE_EXTRA_CONFIG+=(-DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT})
    _VERBOSE=""
  fi
  unset MACOSX_DEPLOYMENT_TARGET
  export MACOSX_DEPLOYMENT_TARGET
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_AR=${AR})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_RANLIB=${RANLIB})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_LINKER=${LD})
fi
if [[ ${HOST} =~ .*linux.* ]]; then
  # I hate you so much CMake.
  LIBRT=$(find ${PREFIX} -name "librt.so")
  LIBPTHREAD=$(find ${PREFIX} -name "libpthread.so")
  LIBUTIL=$(find ${PREFIX} -name "libutil.so")
  _CMAKE_EXTRA_CONFIG+=(-DPTHREAD_LIBRARIES=${LIBPTHREAD})
  _CMAKE_EXTRA_CONFIG+=(-DUTIL_LIBRARIES=${LIBUTIL})
  _CMAKE_EXTRA_CONFIG+=(-DRT_LIBRARIES=${LIBRT})
  if [[ ${RSTUDIO_TARGET} == Server ]]; then
    LIBPAM=$(find ${PREFIX} -name "libpam.so")
    LIBAUDIT=$(find ${PREFIX} -name "libaudit.so")
    LIBDL=$(find ${PREFIX} -name "libdl.so")
    _CMAKE_EXTRA_CONFIG+=(-DPAM_INCLUDE_DIR=${PREFIX}/${HOST}/sysroot/usr/include)
    _CMAKE_EXTRA_CONFIG+=(-DPAM_LIBRARY="${LIBPAM} ${LIBAUDIT}")
    _CMAKE_EXTRA_CONFIG+=(-DDL_LIBRARIES=${LIBDL})
  fi
fi
_CMAKE_EXTRA_CONFIG+=(-DQT_QMAKE_EXECUTABLE=${PREFIX}/bin/qmake)

echo cmake                                    \
      -DCMAKE_INSTALL_PREFIX=${PREFIX}        \
      -DBOOST_ROOT=${PREFIX}                  \
      -DBOOST_VERSION=1.65.1                  \
      -DRSTUDIO_TARGET=${RSTUDIO_TARGET}      \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE}        \
      -DLIBR_HOME=${PREFIX}/lib/R             \
      -DUSE_MACOS_R_FRAMEWORK=FALSE           \
      -DCMAKE_C_COMPILER=$(type -p ${CC})     \
      -DCMAKE_CXX_COMPILER=$(type -p ${CXX})  \
      "${_CMAKE_EXTRA_CONFIG[@]}"             \
      -Wdev --debug-output --trace            \
      .

cmake                                         \
      -DCMAKE_INSTALL_PREFIX=${PREFIX}        \
      -DBOOST_ROOT=${PREFIX}                  \
      -DBOOST_VERSION=1.65.1                  \
      -DRSTUDIO_TARGET=${RSTUDIO_TARGET}      \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE}        \
      -DLIBR_HOME=${PREFIX}/lib/R             \
      -DUSE_MACOS_R_FRAMEWORK=FALSE           \
      -DCMAKE_C_COMPILER=$(type -p ${CC})     \
      -DCMAKE_CXX_COMPILER=$(type -p ${CXX})  \
      "${_CMAKE_EXTRA_CONFIG[@]}"             \
      -Wdev --debug-output --trace            \
      .

# on macOS 10.9, in spite of following: https://unix.stackexchange.com/a/221988
# and those limits seeming to have taken:
# launchctl limit | grep maxfiles
# maxfiles    262144         524288
# .. we still get failures:
# Error writing out generated unit at '$SRC_DIR/src/gwt/gen/org/rstudio/studio/client/rsconnect/ui/RSAccountConnector_Binder__Impl.java':
#  java.io.FileNotFoundException: gen/org/rstudio/studio/client/rsconnect/ui/RSAccountConnector_Binder__Impl.java (Too many open files)
# .. so instead build in series (it may be that running make install twice works just as well here).
# Update: It turns out that the number of files needed is constant and the number of threads has no bearing on this:
# https://groups.google.com/d/msg/google-web-toolkit/EGiOO0g85rI/tGrxa9_Ou9wJ
# When building a ClientBundle with images, the compiler holds all the source image files open at the same time, even if you never refer to the image in your code
# Also for macOS 10.9, the way to increase this limit is to add the following to ~/.bash_profile:
# ulimit -n 2048

# "cmake --build" might be fine on all OSes/generators (though it does
# seem to be building the Debug variant on Xcode), so for now check _XCODE_BUILD
if [[ ${_XCODE_BUILD} == yes ]]; then
  cmake --build . --target install -- ${_VERBOSE} -jobs ${CPU_COUNT} || exit 1
else
  make install -j${CPU_COUNT} ${VERBOSE_CM} || exit 1
fi

if [[ $(uname) == Darwin ]]; then
  cp -rf "${RECIPE_DIR}"/app/RStudio.app ${PREFIX}/rstudioapp
  cp "${RECIPE_DIR}"/osx-post.sh ${PREFIX}/bin/.rstudio-post-link.sh
  cp "${RECIPE_DIR}"/osx-pre.sh ${PREFIX}/bin/.rstudio-pre-unlink.sh
elif [[ $(uname) == Linux ]]; then
  echo "It would be nice to add a .desktop file here, but it would"
  echo "be even nicer if menuinst handled both that and App bundles."
fi

if [[ ${_DEBUG} == yes ]]; then
  echo ""
  echo "# Build finished, since _DEBUG is yes (in build.sh), you should open 2 or 3 new shells:"
  echo ""
  echo "# Shell 1:"
  echo "cd ${SRC_DIR}/src/gwt"
  echo ". ${SYS_PREFIX}/bin/activate ${PREFIX}"
  echo "ant superdevmode"
  echo ""
  echo "# Shell 2:"
  echo "cd ${SRC_DIR}/src/cpp"
  echo "./rserver-dev"
  echo ""
  echo "# Shell 3:"
  echo ". ${SYS_PREFIX}/bin/activate ${PREFIX}"
  echo "# Then open Chrome, browse to:"
  echo "# .. the code server at: http://127.0.0.1:9876"
  echo "# .. the RStudo app at:  http://127.0.0.1:8787"
  echo "google-chrome-stable http://127.0.0.1:9876 http://127.0.0.1:8787 &"
  echo "# and follow the instructions given at:"
  echo "# https://github.com/rstudio/rstudio/wiki/RStudio-Development"
  echo "# If you need to debug rsession (likely you do) then QtCreator from anaconda.org/rdonnelly can help"
  echo "# Make a fixed symlink to the transient source code (-fdebug-prefix-map was used here):"
  echo "[[ -L /usr/local/src/conda/${PKG_NAME}-${PKG_VERSION} ]] && rm -rf /usr/local/src/conda/${PKG_NAME}-${PKG_VERSION}"
  echo "ln -s ${SRC_DIR} /usr/local/src/conda/${PKG_NAME}-${PKG_VERSION}"
  echo "[[ -L /usr/local/src/conda-prefix ]] && rm -rf /usr/local/src/conda-prefix"
  echo "ln -s ${PREFIX} /usr/local/src/conda-prefix"
  echo "
  echo "# Launch QtCreator with some necessary environment variables set:"
  echo "rm ${SRC_DIR}/CMakeLists.txt.user || true"
  echo "     SRC_DIR=${SRC_DIR} \\"
  echo "      PREFIX=${PREFIX} \\"
  echo "    PKG_NAME=${PKG_NAME} \\"
  echo " PKG_VERSION=${PKG_VERSION} \\"
  echo " CONDA_BUILD=1 \\"
  echo "${SYS_PREFIX}/envs/devenv/bin/qtcreator -debug \$(ps aux | grep rsession | grep -v grep | awk '{print \$2}')"
  # If you want to try using QtCreator to hack on the software this might work (if you are very lucky, more likely you
  # will spend hours battling the poor implementation that is QtCreator's CMake integration: imporing existing builds
  # results in dropped configuration parameters; the configuration dialog does not show any parameters while CMake is
  # in a state of not being able to run to successful completion - you are best off hacking CMakeLists.txt.user to add
  # the dropped parameters but overall, as of QtCreator 4.6.0 it is best avoided)
  # echo "${SYS_PREFIX}/envs/devenv/bin/qtcreator ${SRC_DIR}/CMakeLists.txt &"
  exit 1
fi
