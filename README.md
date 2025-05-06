# WinInstaller
© 2025–2026
--
## --WILL UPADTE THIS PAGE LATER-- 

### 📄 Description

**WinInstaller** provides a flashable zip (no PC required) for installing Windows on supported ARM64 devices.

---

### 📋 Prerequisites

- Ensure all necessary partitions for Windows installation (e.g., `win` and `esp`) are already created.
- ⚠️ **Important**: The ESP partition size must be at least **350MB**.

---

### 🔧 Preparation

1. **Download and unpack** this repository as a zip.
2. **Download the PE image** from [here](https://github.com/Kumar-Jy/WinInstaller/releases/download/WinPE/pe.img) and place it in the unpacked folder.
3. **Add your device's UEFI image** (`uefi.img`) to the unpacked folder.
4. **Download the Drivers Pack** for your device and unpack it. Then:
   - Select all files and repack them as `Driver.zip`.
   - Place the modified `Driver.zip` into the unpacked WinInstaller folder.

---

### 📂 Folder Structure

Organize the folder structure as follows:

```plaintext
WinInstaller.zip

-pe.img (WinPE image)
-uefi.img (UEFI image)
-install.bat (Batch script)
-Driver.zip (Driver pack)
-wimlib-imagex (Binary file)
-gdisk (Binary file)
-sta.exe (Executable file)

-META-INF (Folder)
       └── com (Folder)
           └── google (Folder)
               └── update-binary (Binary script)
               └── updater-script (Binary script)
```

*(All file and folder names are case-sensitive.)*

5. **Repack all files/folders** into a zip file. This will create your `WinInstaller.zip`.

---

### 💻 Flashing Instructions

1. **Download the Windows ESD image**:
   - Ensure it is located in the default download folder on your device.
2. **Boot to TWRP/OrangeFox Recovery**:
   - Flash or sideload the `WinInstaller.zip` file.
3. Your device will **automatically reboot** into WinPE and start the Windows installation process.

---

### ⚠️ Important Notes

- Ensure there is **only one** `.esd` or `.wim` file in the `Download` folder.
- Confirm that all file and folder names match the specifications above. **Names are case-sensitive**.
- All zip files must be packed **without compression**.

