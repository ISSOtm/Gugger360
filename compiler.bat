@echo off
cls
echo === COMPILATION ===
rgbasm -i includes/ -o gugger.obj gugger.asm
echo.
echo COMPILATION TERMINEE
echo.
echo.
echo === LINKING ===
rgblink -m gugger.map -n gugger.sym -o gugger.gb gugger.obj
echo.
echo LINKING TERMINE
echo.
echo.
echo === FIXING ===
rgbfix -p 0 -t "GUGGER360" -s -l 0x33 -j -v gugger.gb
echo.
echo FIXING TERMINE
echo.
echo.
echo === CLEANUP ===
del gugger.obj
echo.
echo CLEANUP TERMINE
echo.
pause
echo.
echo.
echo === COMPRESSION ===
del gugger.zip
"%ProgramFiles%\7-Zip\7z" a gugger.zip gugger.gb gugger.map gugger.sym readme.txt manuel.png -mmt
echo.
echo COMPRESSION TERMINEE
echo.
echo LES FICHIERS SONT PRETS !
pause