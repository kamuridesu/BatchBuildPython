@echo off
setlocal
@echo on
echo Downloading python...
@echo off

@REM check system arch
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

@REM download the standalone version based of arch
if %OS%==32BIT curl.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-embed-win32.zip --output temp_bin.zip
if %OS%==64BIT curl.exe https://www.python.org/ftp/python/3.10.5/python-3.10.5-embed-amd64.zip --output temp_bin.zip

@REM unzips
powershell -command "Expand-Archive -Force '%~dp0temp_bin.zip' '%~dp0bin'"
del temp_bin.zip

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

@echo on
echo "Package successfully created!"
echo "Run with main.exe"
