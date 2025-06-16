### 📂 Folder Watch & FTP Sync Utility

This project provides an automated way to **monitor a local folder** and **trigger FTP synchronization via WinSCP** when changes are detected (file additions or deletions).

---

### 🧾 Files

- `check_folder.ps1`: PowerShell script that watches a folder and triggers `WinSCP` sync when changes occur or after a fixed interval.
- `start.bat`: Batch script to launch the PowerShell script easily.
- `sync_ftp.txt`: WinSCP command script (not included — must be created based on your FTP configuration).

---

### 🔧 Configuration

1. **Set the folder to monitor**  
   In `check_folder.ps1`, edit the following line:

   ```powershell
   $folderToWatch = "C:\Path\To\Your\Folder"
   ```

2. **Create your `sync_ftp.txt` script**  
   This file should contain the WinSCP FTP commands, for example:

   ```
   open ftp://user:password@host
   lcd C:\Path\To\Your\Folder
   cd /remote/path
   synchronize remote
   exit
   ```

3. **Adjust WinSCP path if necessary**  
   In `check_folder.ps1`, modify this if WinSCP is installed elsewhere:

   ```powershell
   $process.FileName = "C:\Program Files (x86)\WinSCP\WinSCP.com"
   ```

---

### ▶️ How to Run

1. Double-click `start.bat`  
   This will launch the folder watcher and sync process.

2. The script will:
   - Check for file changes every second.
   - Trigger `WinSCP` sync if changes are detected or every 5 seconds by default.

---

### 📝 Notes

- Requires [WinSCP](https://winscp.net/eng/download.php) installed.
- Make sure PowerShell execution policy allows running scripts (`Bypass` is used in the `.bat`).