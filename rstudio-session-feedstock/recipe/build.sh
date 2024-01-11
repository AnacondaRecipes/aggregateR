#!/bin/sh

sed -i \
  -e '/^ln/d' \
   ./dependencies/common/install-soci

sed -i \
  -e '/add_subdirectory.package/d' \
  ./CMakeLists.txt

sed -i \
  -e 's/. validate existence/continue()/' \
  -e '/SKIP_BUILD_RPATH/d' \
  ./src/cpp/session/CMakeLists.txt

export RSTUDIO_TOOLS_ROOT="${PWD}/rstudio-tools"

./dependencies/common/install-soci

mkdir build
pushd build > /dev/null

#-DCMAKE_FIND_ROOT_PATH="${PREFIX}" \

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_PREFIX_PATH="${PREFIX}" \
  -DRSTUDIO_BOOST_REQUESTED_VERSION=1.82.0 \
  -DRSTUDIO_USE_SYSTEM_YAML_CPP=ON \
  -DRSTUDIO_USE_SYSTEM_BOOST=ON \
  -DRSTUDIO_CONFIG_SESSION_ONLY=ON \
  -DRSTUDIO_DEVELOPMENT=OFF \
  -DRSTUDIO_SERVER=OFF \
  -DRSTUDIO_DESKTOP=OFF \
  -DRSESSION_ALTERNATE_BUILD=ON \
  -G Ninja \
  ..

cmake \
  --build .

cmake \
  --install .

popd > /dev/null
