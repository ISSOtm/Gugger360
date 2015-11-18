@echo off
cls
echo === COMPILATION ===
rgbasm -ogugger.obj gugger.asm
echo.
echo COMPILATION TERMINEE
echo.
echo.
echo === LINKING ===
rgblink -mgugger.map -ngugger.sym -ogugger.gb gugger.obj
echo.
echo LINKING TERMINE
echo.
echo.
echo === FIXING ===
rgbfix -p 0 -t "GUGGER360" -k "  " -s -l 0x33 -j -v gugger.gb
echo.
echo FIXING TERMINE
echo.
echo.
echo === CLEANUP ===
del gugger.obj
echo.
echo CLEANUP TERMINE
echo.
echo.
echo.
echo LE FICHIER EST PRET !
pause