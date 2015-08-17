@echo off
title Cyanogen OS Factory Image Downloader v0.1
setlocal EnableExtensions
setlocal EnableDelayedExpansion

echo.
echo Killing any previous instance of adb server (if running)...
%~dp0adb kill-server
echo.
echo Starting new instance of adb server...
%~dp0adb start-server
echo.
echo Checking if adb can detect the connected device...
%~dp0adb get-state | FINDSTR device >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	echo.
	echo Device online :^)
	echo.
	%~dp0adb devices
) else (
	echo.
	echo No device is detected by adb :^(
	echo Make sure that proper drivers are installed and USB debugging is turned on.
	goto close
)

for /f "tokens=*" %%a in (
'%~dp0adb shell getprop ro.product.manufacturer'
) do (
set _manufacturer=%%a
)

for /f "tokens=*" %%a in (
'%~dp0adb shell getprop ro.product.device'
) do (
set _device=%%a
)

set _cosdevice=true
if not "%_device%"=="A0001" if not "%_device%"=="YUREKA" if not "%_device%"=="YUPHORIA" set _cosdevice=false
if "%_cosdevice%"=="true" (
	goto workplace
) else (
	echo Connected device is %_manufacturer% %_device%, which does not come with Cyanogen OS.
	goto close
)

:workplace
for /f "tokens=*" %%a in (
'%~dp0adb shell getprop ro.cm.device'
) do (
set _devicecodename=%%a
)

for /f "tokens=*" %%a in (
'%~dp0adb shell getprop ro.cm.version'
) do (
set _version=%%a
)

for /f "tokens=*" %%a in (
'%~dp0adb shell getprop ro.build.version.incremental'
) do (
set _build=%%a
)

echo Connected device:                 %_manufacturer% %_device% (%_devicecodename%)
echo Installed version of Cyanogen OS: %_version% 
echo.
echo Links.txt created with all possible download links :)

echo http://builds.cyngn.com/cyanogen-os/%_devicecodename%/%_version%/%_build%/cm-%_version%-signed.zip>Links.txt
echo http://builds.cyngn.com/cyanogen-os/%_devicecodename%/%_version%/%_build%/cm-%_version%-signed-fastboot.zip>>Links.txt
echo http://builds.cyngn.com/cyanogen-os/%_devicecodename%/%_version%/%_build%/cm-%_version%-boot-debuggable.img>>Links.txt

%~dp0adb kill-server

echo.
echo [1] Start downloading factory image using wget
echo [2] Open Links.txt to view contents
echo [3] Manually download factory image later
echo.
choice /C 123 /M "What should be your next action"
if errorlevel 3 goto three
if errorlevel 2 goto two
if errorlevel 1 goto one
goto close

:one
for /f "tokens=2 delims==" %%a in ('wmic path Win32_Processor get AddressWidth /value') do (
	set _OSarch=%%a
)
echo.
echo Starting download... & %~dp0wget%_OSarch% -i Links.txt
goto close
:two
echo.
echo ======================================================
echo.
type Links.txt
echo.
echo ======================================================
goto close
:three
echo.
echo Use your favorite application to download the files.
echo Get the links from Links.txt.
goto close

:close
echo.
echo Press any key to exit...
pause >nul