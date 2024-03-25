REM Use pkg-config to get the correct flags for netcdf
set PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig

pkg-config --cflags netcdf >cflags
set /p CPPFLAGS=<cflags
pkg-config --libs netcdf >ldflags
set /p LDFLAGS=<ldflags

"%R%" CMD INSTALL --build . --configure-args="CPPFLAGS='%CPPFLAGS%' LDFLAGS='%LDFLAGS%'"
IF %ERRORLEVEL% NEQ 0 exit 1