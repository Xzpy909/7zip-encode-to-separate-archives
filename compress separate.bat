@echo off
set "SevenZipPath=C:\Program Files\7-Zip\7z.exe"
set "ArchiveType=7z"  rem Using 7z format for maximum compression
set "CompressionSettings=-mx=9 -md=64m -mfb=64 -ms=on -mmt=off" rem Ultra Settings

rem Check if 7z.exe exists
if not exist "%SevenZipPath%" (
    echo Error: 7-Zip executable not found at "%SevenZipPath%"
    pause
    exit /b 1
)

rem Loop through all selected files/folders passed to the script
:loop
if "%~1"=="" goto :eof

set "InputPath=%~f1"
set "ArchiveName=%~n1"
set "OutputFolder=%~dp1"
set "OutputArchive=%OutputFolder%%ArchiveName%.%ArchiveType%"

rem Check if the input path is a directory (folder)
if exist "%InputPath%\" (
    echo Compressing folder: "%InputPath%" with Ultra settings...
    rem a - Add to archive
    rem r - Recurse subdirectories
    rem %InputPath%\* - Add all contents of the folder (not the folder itself)
    "%SevenZipPath%" a "%OutputArchive%" "%InputPath%\*" -r %CompressionSettings% -t%ArchiveType%
) else (
    echo Skipping file: "%InputPath%" (only folders are processed)
)

shift
goto :loop

:eof
echo.
echo Compression Complete. Press any key to close.
pause