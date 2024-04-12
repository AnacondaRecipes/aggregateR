set PKG_LIBS=-L$(R_HOME)/../../Library/bin -lxml2 -liconv -lz -lws2_32 -lstdc++ -lglpk -lgmp -lgfortran $(BLAS_LIBS) $(LAPACK_LIBS) -llzma

sed -i.bak "s/^PKG_LIBS/#PKG_LIBS/" src/Makevars.ucrt

"%R%" CMD INSTALL --build . --configure-args="%PKG_LIBS%"
if errorlevel 1 exit 1
