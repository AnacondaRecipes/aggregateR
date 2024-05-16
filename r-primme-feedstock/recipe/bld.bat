sed -i -e 's/ $(INCLUDE) / /' src/primme/make_primme

"%R%" CMD INSTALL --build .
IF %ERRORLEVEL% NEQ 0 exit 1
