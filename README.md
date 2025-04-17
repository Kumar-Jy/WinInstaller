# WinInstaller
© 2023–2024

## Description
Windows Installer flashable zip [without PC] for supported ARM64 devices.

### Prerequisites
- All necessary partition for Windows ( such as win and esp) should already be created
-	Ensure the ESP partition size is not smaller then 350MB

### Preparation
- Download this repository as a zip and unpack it.
-	Download the pe.img from [here](https://github.com/Kumar-Jy/WinInstaller/releases/download/WinPE/pe.img) and add it to the /installer folder.
-	Place the uefi.img of your device in the unpacked folder.
-	Download the Drivers pack for your device, unpack it. and copy all files/folders in /installer/Driver.
- Place the modified Driver.zip into the unpacked WinInstaller folder. It should contains Driver.zip, pe.img, uefi.img, and META-INF (all file and folder names are case-sensitive).
- Select all files/folders and repack them as a zip file. Your WinInstaller.zip is now ready.

### Flashing Instructions
- Download the Windows ESD image (it should be in the default download folder in your device memory).
- Boot to TWRP/OrangeFox recovery and flash/sideload WinInstaller.zip.
- The device will automatically reboot to WinPE and begin the Windows installation.
  
> Important Notes
- Ensure there is not more then one esd or wim file should be in Download folder.
- Ensure all files and folder names match those specified above. All files and letters are case-sensitive.
- zip files should be packed as normal compression.
