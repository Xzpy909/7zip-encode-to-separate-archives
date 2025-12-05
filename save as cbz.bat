@echo off
setlocal

:: --- CONFIGURATION ---
:: Ensure this path matches your 7-Zip installation
set "sevenzip=C:\Program Files\7-Zip\7z.exe"

:: Check if 7-Zip exists
if not exist "%sevenzip%" (
    echo Error: 7-Zip executable not found at: "%sevenzip%"
    pause
    goto :eof
)

:: --- PROCESSING LOOP ---
:loop
:: If no more files are selected, end the script
if "%~1"=="" goto :eof

:: Check if input is a folder to apply the "flat" structure logic
if exist "%~1\*" (
    echo Packing contents of "%~n1" to CBZ...
    
    :: -tzip forces the ZIP format
    :: -mx=9 uses the highest compression level for ZIP
    :: "%~1\*" selects contents only (no root folder)
    "%sevenzip%" a -tzip -mx=9 "%~dpn1.cbz" "%~1\*"
) else (
    echo "%~nx1" is a file. Compressing normally...
    "%sevenzip%" a -tzip -mx=9 "%~dpn1.cbz" "%~1"
)

:: Move to the next item selected
shift
goto loop