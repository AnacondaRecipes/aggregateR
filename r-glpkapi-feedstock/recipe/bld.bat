REM Fix the place of the GLPK library on Windows
sed -i.bak "s!^PKG_LIBS=-L${GLPK_HOME}/lib!PKG_LIBS=-L$(R_HOME)/../../Library/bin!" src/Makevars.win

"%R%" CMD INSTALL --build .
IF %ERRORLEVEL% NEQ 0 exit 1
