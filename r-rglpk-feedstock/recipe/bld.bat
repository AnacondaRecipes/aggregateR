sed -i.bak "s!^PKG_LIBS=-L${GLPK_HOME}/lib!PKG_LIBS=-L$(R_HOME)/../../Library/bin!" src/Makevars.win
sed -i.bak "s!^PKG_LIBS=-L${GLPK_HOME}/lib!PKG_LIBS=-L$(R_HOME)/../../Library/bin!" src/Makevars.ucrt


"%R%" CMD INSTALL --build .
IF %ERRORLEVEL% NEQ 0 exit 1
