@echo off
@echo on
echo Downloading python...
@echo off
cd $1

@REM check system arch
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

@REM download the standalone version based of arch
if %OS%==32BIT curl.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-embed-win32.zip --output temp_bin.zip
if %OS%==64BIT curl.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-embed-amd64.zip --output temp_bin.zip

@REM unzips
powershell -command "Expand-Archive -Force '%~dp0temp_bin.zip' '%~dp0bin'"
del temp_bin.zip

IF EXIST requirements.txt (
    @REM start virtual env
    @echo on
    echo creating virtual env
    @echo off
    python -m venv .

    @REM install required packages
    @echo on
    echo installing packages...
    @echo off
    %~dp0Scripts\pip3.exe install -r requirements.txt

    @REM moving packages
    for /d %%A in (%~dp0Lib\site-packages\*) do (
        move "%%A" "%~dp0bin"
    )

    @REM Deleting trash
    rmdir "%~dp0Include" /q /s
    rmdir "%~dp0Lib" /q /s
    rmdir "%~dp0Scripts" /q /s
    del pyvenv.cfg
)
curl.exe https://raw.githubusercontent.com/kamuridesu/BatchBuildPython/main/main.exe --output main.exe

echo "Package successfully built!"
echo "You can run the app using main.exe"
echo "Done!"
