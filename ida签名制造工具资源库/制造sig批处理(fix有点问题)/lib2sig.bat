for  %%i in (*.lib) do call:sigmake %%~ni
echo.&pause&goto:eof 
:sigmake
md %1_objs
md sig
md error_lib
copy %1.lib %1_objs
cd %1_objs
for /F %%i in ('link -lib /list %1.lib') do link -lib /extract:%%i %1.lib
for %%i in (*.obj) do pcf %%i
sigmake -n"%1.lib" *.pat %1.sig
if exist %1.exc for %%i in (%1.exc) do find /v ";" %%i > abc.exc 
if exist %1.exc for %%i in (%1.exc) do > abc.exc more +2 "%%i"
copy abc.exc %1.exc
del abc.exc
sigmake -n"%1.lib" *.pat %1.sig
copy %1.sig ..\sig
if not exist %1.sig (copy %1.lib ..\error_lib)
if not exist %1.sig (del ..\%1.lib)
cd ..
del %1_objs /s /q
rd %1_objs
goto:eof  