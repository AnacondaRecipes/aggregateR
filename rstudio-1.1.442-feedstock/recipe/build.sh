#!/bin/sh

# Changing to not using an .app bundle is a bit tricky. I need to use
# Xcode.
if [[ ${DEBUG_C} == yes ]]; then
  # BUILD_TYPE=RelWithDebInfo
  BUILD_TYPE=Debug
else
  BUILD_TYPE=Release
fi

if [[ ${rstudio_variant} == -server ]]; then
  RSTUDIO_TARGET=Server
else
  RSTUDIO_TARGET=Desktop
fi

# This can be useful sometimes, but in general QtCreator works better since
# it's what upstream uses.
_XCODE_BUILD=no

# Boost 1.65.1 cannot be used with -std=c++17 it seems. -std=c++14 works.
re='(.*[[:space:]])\-std\=[^[:space:]]*(.*)'
if [[ "${CXXFLAGS}" =~ $re ]]; then
  export CXXFLAGS="${BASH_REMATCH[1]} -std=c++11 ${BASH_REMATCH[2]}"
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

mkdir build
pushd build

if ! which javac; then
  echo "Fatal: Please install javac with your system package manager"
  exit 1
fi

if ! which ant; then
  echo "Fatal: Please install ant with your system package manager"
  exit 1
fi

# Note, you can select a different default R interpreter launching
# RStudio by:
# export RSTUDIO_WHICH_R=${CONDA_PREFIX}/bin/R

# You can use this so that -Wl,-rpath-link gets used during linking
# executables. Without it, -Wl,-rpath is used anyway (and also) and
# either works fine from the perspective of ld finding transitively
# linked shared libraries:
# -DCMAKE_PLATFORM_RUNTIME_PATH=${PREFIX}/lib

export BOOST_ROOT=${PREFIX}

_VERBOSE=${VERBOSE_CM}

declare -a _CMAKE_EXTRA_CONFIG
if [[ ${target_platform} == osx-64 ]]; then
  if [[ ${_XCODE_BUILD} == yes ]]; then
    _CMAKE_EXTRA_CONFIG+=(-G'Xcode')
    _CMAKE_EXTRA_CONFIG+=(-DCMAKE_OSX_ARCHITECTURES=x86_64)
    _VERBOSE=""
  fi
  export MACOSX_DEPLOYMENT_TARGET=10.9
  export CMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT}
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_OSX_DEPLOYMENT_TARGET=10.9)
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_AR=${AR})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_RANLIB=${RANLIB})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_LINKER=${LD})
  _CMAKE_EXTRA_CONFIG+=(-DRSTUDIO_USE_LIBCXX=TRUE)
  _CMAKE_EXTRA_CONFIG+=(-DRSTUDIO_USE_LIBSTDCXX=FALSE)
fi
if [[ ${target_platform} =~ .*linux.* ]]; then
  # I hate you so much CMake.
  LIBRT=$(find ${PREFIX} -name "librt.so")
  LIBPTHREAD=$(find ${PREFIX} -name "libpthread.so")
  LIBUTIL=$(find ${PREFIX} -name "libutil.so")
  _CMAKE_EXTRA_CONFIG+=(-DPTHREAD_LIBRARIES=${LIBPTHREAD})
  _CMAKE_EXTRA_CONFIG+=(-DUTIL_LIBRARIES=${LIBUTIL})
  _CMAKE_EXTRA_CONFIG+=(-DRT_LIBRARIES=${LIBRT})
  # May only be necessary for server?
  export CPPFLAGS="${CPPFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
  export CXXFLAGS="${CXXFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
  export CFLAGS="${CFLAGS} -Wl,-rpath-link,${PREFIX}/lib"
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


#      -Wdev --debug-output --trace            \

cmake                                         \
      -DCMAKE_INSTALL_PREFIX=${PREFIX}        \
      -DBOOST_ROOT=${PREFIX}                  \
      -DBOOST_VERSION=1.67.0                  \
      -DRSTUDIO_TARGET=${RSTUDIO_TARGET}      \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE}        \
      -DLIBR_HOME=${PREFIX}/lib/R             \
      -DUSE_MACOS_R_FRAMEWORK=FALSE           \
      -DCMAKE_C_COMPILER=$(type -p ${CC})     \
      -DCMAKE_CXX_COMPILER=$(type -p ${CXX})  \
      "${_CMAKE_EXTRA_CONFIG[@]}"             \
      -Wdev --debug-output --trace            \
      ..

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

# make rstudio/fast ${VERBOSE_CM}
# exit 1

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

if [[ ${rstudio_variant} == -server ]]; then
  [[ ! -d "{PREFIX}"/www ]] && mkdir "${PREFIX}"/www
  mv "${PREFIX}"/share/rstudio/www/* "${PREFIX}"/www/
fi

# Please do not remove this block. If you ever need it you will thank me.
if [[ ${DEBUG_C} == yes ]]; then
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
  echo "R_HOME=${CONDA_PREFIX}/lib/R R_DOC_DIR=${CONDA_PREFIX}/lib/R/doc ./rserver-dev"
  echo ""
  echo "# Shell 3:"
  echo ". ${SYS_PREFIX}/bin/activate ${PREFIX}"
  echo "# Then open Chrome, browse to:"
  echo "# .. the code server at: http://127.0.0.1:9876"
  echo "# .. the RStudo app at:  http://127.0.0.1:8787"
  if [[ $(uname) == Darwin ]]; then
    echo "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome http://127.0.0.1:9876 http://127.0.0.1:8787 &"
  else
    echo "google-chrome-stable http://127.0.0.1:9876 http://127.0.0.1:8787 &"
  fi
  echo "# and follow the instructions given at:"
  echo "# https://github.com/rstudio/rstudio/wiki/RStudio-Development"
  echo "# If you need to debug rsession (likely you do) then QtCreator from anaconda.org/rdonnelly can help"
  echo "# Make a fixed symlink to the transient source code (-fdebug-prefix-map was used here):"
  echo "[[ -L /usr/local/src/conda/${PKG_NAME}-${PKG_VERSION} ]] && rm -rf /usr/local/src/conda/${PKG_NAME}-${PKG_VERSION}"
  echo "ln -s ${SRC_DIR} /usr/local/src/conda/${PKG_NAME}-${PKG_VERSION}"
  echo "[[ -L /usr/local/src/conda-prefix ]] && rm -rf /usr/local/src/conda-prefix"
  echo "ln -s ${PREFIX} /usr/local/src/conda-prefix"
  echo ""
  echo "# Launch QtCreator with some necessary environment variables set:"
  echo "rm ${SRC_DIR}/CMakeLists.txt.user || true"
  echo "     SRC_DIR=${SRC_DIR} \\"
  echo "      PREFIX=${PREFIX} \\"
  echo "    PKG_NAME=${PKG_NAME} \\"
  echo " PKG_VERSION=${PKG_VERSION} \\"
  echo "      R_HOME=${CONDA_PREFIX}/lib/R \\"
  echo "   R_DOC_DIR=${CONDA_PREFIX}/lib/R/doc \\"
  echo " CONDA_BUILD=1 \\"
  echo "${SYS_PREFIX}/envs/devenv/bin/qtcreator -debug \$(ps aux | grep rsession | grep -v grep | awk '{print \$2}')"
  # If you want to try using QtCreator to hack on the software this might work (if you are very lucky, more likely you
  # will spend hours battling the poor implementation that is QtCreator's CMake integration: imporing existing builds
  # results in dropped configuration parameters; the configuration dialog does not show any parameters while CMake is
  # in a state of not being able to run to successful completion - you are best off hacking CMakeLists.txt.user to add
  # the dropped parameters but overall, as of QtCreator 4.6.0 it is best avoided)
  # echo "${SYS_PREFIX}/envs/devenv/bin/qtcreator ${SRC_DIR}/CMakeLists.txt &"
  exit 0
fi
