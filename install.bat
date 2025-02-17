@echo off
set espname=ESP....
set uefiname=......img
set devicename=.........
set secureboot=0

rem Set the console width to 800 characters
mode 800
echo.
echo ============================================================
echo   Welcome to Windows Installation in %devicename%    
echo           Version: WinInstaller_......_.....               
echo           Date   : 16-Feb-2025                           
echo           Made by: Kumar_Jy                              
echo   Help and suggestions: ArKT, Sog, Andre_grams.       
echo   Drivers And UEFI: Project-Aloha,......,..... And..
echo ============================================================
echo.

if not exist "%~d0\boot.img" echo Failed to find the boot image. & goto fail
if not exist "%~dp0sta.exe" echo Failed to find sta.exe. & goto fail
"%~dp0sta" -p "%~d0\boot.img" -n || echo Failed to flash the boot image. && goto fail

echo(
echo ============================================================
echo             Checking for Windows installation...
echo ============================================================
echo(

rem Check if Windows is already installed
if exist %~d0\Windows\explorer.exe (
    echo Windows is already installed.
    goto formatAndAssign
)

echo(
echo ============================================================
echo             Searching for the index value of "Windows Image"...
echo ============================================================
echo(

if exist "%~dp0install.win" set "imageFile=%~dp0install.wim" & goto foundImage
if exist "%~dp0install.esd" set "imageFile=%~dp0install.esd" & goto foundImage

echo No ESD or WIM Image was found in %~dp0. & goto fail

:foundImage
echo(
echo ============================================================
echo           Image file found at %imageFile%, Windows drive set to %~d0
echo ============================================================
echo(
echo ============================================================
echo Searching index of Windows in the following order ........
echo       1.  Windows 11 Pro
echo       2.  Windows 11 IoT Enterprise LTSC
echo	   3.  Windows 11 Enterprise
echo       4.  Windows 10 Pro
echo       5.  Windows 11 Home
echo       6.  Windows 10 Home
echo ============================================================
echo(

rem Find the index for Windows 11 Pro
call :indexlookup "Windows 11 Pro" && goto indexFound

rem Find the index for Windows 11 IoT Enterprise LTSC
call :indexlookup "Windows 11 IoT Enterprise LTSC" && goto indexFound

rem Find the index for Windows 11 Enterprise
call :indexlookup "Windows 11 Enterprise" && goto indexFound

rem Find the index for Windows 10 Pro
call :indexlookup "Windows 10 Pro" && goto indexFound

rem Find the index for Windows 11 Home
call :indexlookup "Windows 11 Home" && goto indexFound

rem Find the index for Windows 10 Home
call :indexlookup "Windows 10 Home" && goto indexFound

rem PLEASE REWORD THIS THANK YOU
echo No valid edition found on Windows image
echo Please check your Windows image and restart installation.
pause
exit /b

:indexFound
echo(
echo ============================================================
echo           Starting Windows installation.....
echo ============================================================
echo(

rem Apply the selected index to the target drive
echo Applying image to %targetDrive%...
dism /Apply-Image /ImageFile:"%imageFile%" /Index:%index% /ApplyDir:%~d0 || echo Failed to apply the image. && goto fail
echo Image applied successfully!
echo(

:formatAndAssign
echo ============================================================
echo           Formatting and assigning drive letter to bootloader
echo ============================================================
echo(

for /f "tokens=2 delims= " %%f in ('echo list volume ^| diskpart ^| findstr /i "FAT32" ^| findstr /i "PE"') do (
	set volumeNumber=%%f
	goto volFound
)

echo No FAT32 PE volume found. Searching for %espname%...
for /f "tokens=2 delims= " %%f in ('echo list volume ^| diskpart ^| findstr /i "FAT32" ^| findstr /i "%espname%"') do (
    set volumeNumber=%%f
    goto volFound
)

echo No FAT32 ESP or PE volume found. & goto fail

:volFound
echo Found FAT32 volume with ESP or PE, Volume Number %volumeNumber%

rem Format the volume, assign the drive letter S, and label it accordingly
(
    echo select volume %volumeNumber%
    echo format fs=fat32 quick label=%espname%
    echo assign letter=S
) | diskpart

echo(
echo ============================================================
echo           Creating bootloader files...
echo ============================================================
echo(

call :addbootentry %~d0 || goto fail

echo(
echo ==========================================================
echo           Now performing driver installation...
echo ==========================================================

rem Searching for an XML file in the target directory
set "repo=%~dp0Driver"
for %%f in ("%repo%\definitions\Desktop\ARM64\Internal\*.xml") do (
    set "xmlFile=%%f"
    goto xmlFound
)

rem i really don't like this
for /d %%a in ("%repo%\*") do (
	for %%b in ("%%a\definitions\Desktop\ARM64\Internal\*.xml") do (
		set "repo=%%a"
		set "xmlFile=%%b"
		echo soggy drivers detected
		goto xmlFound
	)
)

echo No XML files found in %repo%\definitions\Desktop\ARM64\Internal\. & goto fail

:xmlFound
echo XML file found at %xmlFile%.

"%repo%\tools\DriverUpdater\%PROCESSOR_ARCHITECTURE%\DriverUpdater.exe" -r "%repo%\." -d "%xmlFile%" -p %~d0 || echo Failed to install the drivers. && goto fail

echo(
echo ==========================================================
echo Installation completed. Rebooting into Windows in 5 seconds.
echo This script was written by Kumar-Jy, & Bibarub
echo ==========================================================
"%~dp0sta" -p "%~dp0%uefiname%" -n || echo Failed to flash the UEFI image. && goto fail

echo(
echo ==========================================================
echo           Cleaning installation files........
echo ==========================================================
rmdir /s /q "%~dp0" & shutdown /r /t 5
exit /b

:fail
echo Take a picture of the error, force reboot and ask for help on Telegram @wininstaller or @woahelperchat
pause
exit /b 1
:addbootentry
bcdboot %~1\Windows /s S: /f UEFI || exit /b 1
rem bcdedit /store S:\EFI\Microsoft\BOOT\BCD /set {default} recoveryenabled no || exit /b 1
if not "%secureboot%"=="1" (
	bcdedit /store S:\EFI\Microsoft\BOOT\BCD /set {default} testsigning on || exit /b 1
	bcdedit /store S:\EFI\Microsoft\BOOT\BCD /set {default} nointegritychecks on || exit /b 1
)
exit /b
:indexlookup
for /f "tokens=2 delims=: " %%a in ('dism /Get-WimInfo /WimFile:%imageFile% ^| findstr /i /c:"Index :"') do (
    set currentIndex=%%a
    for /f "delims=" %%b in ('dism /Get-WimInfo /WimFile:%imageFile% /Index:%%a ^| findstr /i /c:"Name : %~1"') do (
        set index=%%a
		echo Index value %%a found for %~1
        exit /b
    )
)
echo %~1 not found in the image file.
exit /b 1
