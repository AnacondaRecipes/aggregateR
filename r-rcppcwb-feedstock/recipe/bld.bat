@REM If __MINGW__ is not defined PCRE2_* are set by these calls to a
@REM shell script (which doesn't work so smoothly on a Windows box)
bash pcre2-config --cflags >pcre2-cflags.txt
set /p PCRE2_DEFINES=<pcre2-cflags.txt
bash pcre2-config --libs8 >pcre2-libs.txt
set /p PCRE2_LIBS=<pcre2-libs.txt

@REM The __MINGW__ build is keen on -DPCRE2_STATIC which we can
@REM sidestep
sed -i.bak -e '/PCRE2_DEFINES := -DPCRE2_STATIC/iifndef PCRE2_DEFINES' -e '/PCRE2_DEFINES := -DPCRE2_STATIC/aendif' src\cwb\definitions.mk

"%R%" CMD INSTALL --build .
IF %ERRORLEVEL% NEQ 0 exit 1
