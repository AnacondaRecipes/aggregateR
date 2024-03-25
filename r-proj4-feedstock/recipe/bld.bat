REM Fix PKG_LIBS on Windows.
REM Libraries -lrtmp, -lgcrypt, -lidn2 seems are not needed on Windows.
set PKG_LIBS= -lproj -lsqlite3 -lcurl -lbcrypt -ltiff -ljpeg -lssl -lssh2 -lcrypto -lgdi32 -lz -lzstd -lwebp $(LIBSHARPYUV) -llzma -lgdi32 -lcrypt32 -liconv -lws2_32 -lwldap32 -lwinmm -lstdc++
sed -i.bak "s/^PKG_LIBS/#PKG_LIBS/" src/Makevars.ucrt


"%R%" CMD INSTALL --build . --configure-args="%PKG_LIBS%"