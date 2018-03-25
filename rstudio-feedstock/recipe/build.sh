# Changing to not using an .app bundle is a bit tricky. I need to use
# Xcode.
_XCODE_BUILD=0
BUILD_TYPE=Release
# BUILD_TYPE=RelWithDebInfo

# Boost 1.65.1 cannot be used with -std=c++17 it seems. -std=c++14 works.
re='(.*[[:space:]])\-std\=[^[:space:]]*(.*)'
if [[ "${CXXFLAGS}" =~ $re ]]; then
  export CXXFLAGS="${BASH_REMATCH[1]} -std=c++14 ${BASH_REMATCH[2]}"
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

rm -rf build || true
mkdir build || true
cd build

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
_VERBOSE="VERBOSE=1"

declare -a _CMAKE_EXTRA_CONFIG
if [[ ${HOST} =~ .*darwin.* ]]; then
  if [[ ${_XCODE_BUILD} == 1 ]]; then
    _CMAKE_EXTRA_CONFIG+=(-G'Xcode')
    _CMAKE_EXTRA_CONFIG+=(-DCMAKE_OSX_ARCHITECTURES=x86_64)
    _VERBOSE=""
  fi
  _CMAKE_EXTRA_CONFIG+=(-DRSTUDIO_USE_LIBCXX=TRUE)
  unset MACOSX_DEPLOYMENT_TARGET
  export MACOSX_DEPLOYMENT_TARGET
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_AR=${AR})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_RANLIB=${RANLIB})
  _CMAKE_EXTRA_CONFIG+=(-DCMAKE_LINKER=${LD})
fi
_CMAKE_EXTRA_CONFIG+=(-DQT_QMAKE_EXECUTABLE=${PREFIX}/bin/qmake)

#      -Wdev --debug-output --trace                \

echo cmake                                    \
      -DCMAKE_INSTALL_PREFIX=${PREFIX}        \
      -DBOOST_ROOT=${PREFIX}                  \
      -DBOOST_VERSION=1.65.1                  \
      -DRSTUDIO_TARGET=Desktop                \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE}        \
      -DLIBR_HOME=${PREFIX}/lib/R             \
      -DUSE_MACOS_R_FRAMEWORK=FALSE           \
      -DCMAKE_C_COMPILER=$(type -p ${CC})     \
      -DCMAKE_CXX_COMPILER=$(type -p ${CXX})  \
      "${_CMAKE_EXTRA_CONFIG[@]}"             \
      -Wdev --debug-output --trace            \
      ..

cmake                                         \
      -DCMAKE_INSTALL_PREFIX=${PREFIX}        \
      -DBOOST_ROOT=${PREFIX}                  \
      -DBOOST_VERSION=1.65.1                  \
      -DRSTUDIO_TARGET=Desktop                \
      -DCMAKE_BUILD_TYPE=${BUILD_TYPE}        \
      -DLIBR_HOME=${PREFIX}/lib/R             \
      -DUSE_MACOS_R_FRAMEWORK=FALSE           \
      -DCMAKE_C_COMPILER=$(type -p ${CC})     \
      -DCMAKE_CXX_COMPILER=$(type -p ${CXX})  \
      "${_CMAKE_EXTRA_CONFIG[@]}"             \
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

# "cmake --build" might be fine on all OSes/generators (though it does
# seem to be building the Debug variant on Xcode), so for now check _XCODE_BUILD
if [[ ${_XCODE_BUILD} == 1 ]]; then
  cmake --build . --target install -- ${_VERBOSE} || exit 1
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

# exit 1
