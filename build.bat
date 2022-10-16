@echo off
@echo on
cd %1
echo Downloading python...
@echo off

@REM check system arch
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

@REM download the standalone version based of arch
if %OS%==32BIT curl.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-embed-win32.zip --output temp_bin.zip
if %OS%==64BIT curl.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-embed-amd64.zip --output temp_bin.zip

@REM unzips
powershell -command "Expand-Archive -Force 'temp_bin.zip' 'bin'"
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
    Scripts\pip3.exe install -r requirements.txt

    @REM moving packages
    for /d %%A in (Lib\site-packages\*) do (
        move "%%A" "bin"
    )

    @REM Deleting trash
    rmdir "Include" /q /s
    rmdir "Lib" /q /s
    rmdir "Scripts" /q /s
    del pyvenv.cfg
)

if /I NOT "%2" == "noexe" curl.exe https://raw.githubusercontent.com/kamuridesu/BatchBuildPython/main/main.exe --output main.exe
echo ..>> .\bin\python310._pth

echo "Package successfully built!"
echo "You can run the app using main.exe"
echo "Done!"
