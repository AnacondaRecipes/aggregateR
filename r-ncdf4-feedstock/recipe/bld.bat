REM Fix the place of the netcdf library on Windows
set PKG_LIBS=-L$(R_HOME)/../../Library/bin -lnetcdf -lcurl -lhdf5_hl -lhdf5 -lz
sed -i.bak "s/^PKG_LIBS/#PKG_LIBS/" src/Makevars.ucrt
cat src/Makevars.ucrt

dir
"%R%" CMD INSTALL --build . --configure-args="%PKG_LIBS%"
IF %ERRORLEVEL% NEQ 0 exit 1
