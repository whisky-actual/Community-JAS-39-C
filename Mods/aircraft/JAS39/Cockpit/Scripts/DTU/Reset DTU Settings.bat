@echo off
title Reset DTU Settings.bat
color 8f
cls

choice /c YN /m "Do you wish to reset your DTU settings (saved frequencies etc)?"
if %ERRORLEVEL% == 1 (
    cls
    del /q "%~dp0DTU.json"
    copy "%~dp0template\DTU.json" "%~dp0"

    del /q "%~dp0DTU.log"
    (
        echo ==Start of DTU log==) > "%~dp0DTU.log"
    cls
    echo Done! You can now close this window.
    pause
    exit
)
if %ERRORLEVEL% == 2 (
    cls
    echo No settings reset. You can now close this window.
    pause
    exit
)