# IDM-Is-Corrupt
# 📦 This executable eliminates the "IDM is corrupt" window

This guide explains how to convert a PowerShell script (`.ps1`) into an
executable (`.exe`) using the **ps2exe** module.\
This allows you to distribute your program without requiring the user to
open PowerShell directly.

------------------------------------------------------------------------

## 🔧 1. Configure PowerShell to allow scripts

By default, Windows blocks script execution.\
To enable it, run the following in PowerShell:

``` powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force
```

This only applies to the **current user**, without affecting the whole
system.

------------------------------------------------------------------------

## 📥 2. Install the `ps2exe` module

Still in PowerShell, execute:

``` powershell
Install-Module -Name ps2exe -Scope CurrentUser -Force
```

If a message about an untrusted repository appears, type **A** (Yes to
All).

------------------------------------------------------------------------

## 📂 3. File structure

Place the files in a folder, for example:

    📁 Project
     ├── idmiscorrupt.ps1        # Your PowerShell script
     ├── icon.ico                # Icon for the executable

------------------------------------------------------------------------

## ⚙️ 4. Generate the executable

In PowerShell, navigate to the project folder:

Then run:

``` powershell
ps2exe .\idmiscorrupt.ps1 .\idmiscorrupt.exe -noConsole -noOutput -icon "icon.ico"
```

### Parameter explanation:

-   `idmiscorrupt.ps1` → your input script.
-   `idmiscorrupt.exe` → name of the output executable.
-   `-noConsole` → hides the PowerShell window.
-   `-noOutput` → suppresses logs.
-   `-icon "icon.ico"` → sets the executable's icon.

------------------------------------------------------------------------

## ✅ 5. Running

Now just run the generated `.exe`
## Because it is an unsigned executable, Windows may recognize it as a virus after compilation. You can whitelist it in Windows Defender by restoring the application.

The `.exe` will run in the background, only visible in the task manager, I recommend putting it in the Windows startup.

`%appdata%\Microsoft\Windows\Start Menu\Programs\Startup`
