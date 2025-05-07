# WinInstaller
© 2025–2026
--
## --WILL UPADTE THIS PAGE LATER-- 

### 📄 Description

**WinInstaller** provides a flashable zip (Without PC) for installing Windows on supported ARM64 devices.

---

### 📋 Prerequisites

- Ensure all necessary partitions for Windows installation (such as `win` and `esp`) should already be created.
- ⚠️ **Important**: The ESP partition size must be at least **350MB**.

---

### 🔧 Preparation

1. **Download and unpack** this repository as a zip.
2. **Download the PE image** from [here](https://github.com/Kumar-Jy/WinInstaller/releases/download/WinPE/pe.img) and place it in the  `/installer` folder.
3. **Add your device's UEFI image** (`uefi.img`) to the `/installer` folder.
4. **Download the Drivers Pack** for your device, unpack it. Then copy all files/folders in `/installer/Driver` folder.

---

### 📂 Folder Structure

Organize the folder structure as follows:

```plaintext
WinInstaller.zip

-installer (Folder)
       └── Driver (Folder)
       └── install.bat (Batch script)
       └── pe.img (WinPE image)
       └── sta.exe (Executable file)
       └── uefi.img (UEFI image)

-META-INF (Folder)
       └── com (Folder)
           └── bin (Folder)
           |   └── wimlib-imagex (Binary file)
           |   └── gdisk (Binary file)
           └── google (Folder)
               └── android (Folder)
                   └── update-binary (Binary script)
                   └── updater-script (Binary script)
```

*(All file and folder names are case-sensitive.)*

5. **Repack all files/folders** into a zip file. This will create your `WinInstaller.zip`.

---

### 💻 Flashing Instructions

1. **Download the Windows ESD image**:
   - Ensure it is in the on your same device for which you want to install.
2. **Boot to TWRP/OrangeFox Recovery**:
   - Flash or sideload the `WinInstaller.zip` file.
3. Your device will **automatically reboot** into WinPE and start the Windows installation process.

---

### ⚠️ Important Notes

- Ensure there is **only one** `.esd` or `.wim` file in the your device internal storage.
- Confirm that all file and folder names match the specifications above. **Names are case-sensitive**.
- All zip files must be packed **normal compression**.

