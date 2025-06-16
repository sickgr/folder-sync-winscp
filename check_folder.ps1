# check_folder.ps1

# Path to the folder to monitor for changes
$folderToWatch = "C:\Path\To\Your\Folder"

Write-Host "Monitoring folder and syncing via WinSCP..."

# Capture the initial state of the folder (filenames and modification times)
$previousFiles = Get-ChildItem -Path $folderToWatch -Recurse | Select-Object Name, LastWriteTime
$counter = 0

while ($true) {
    Start-Sleep -Seconds 1
    $counter++

    # Get current state of the folder
    $currentFiles = Get-ChildItem -Path $folderToWatch -Recurse | Select-Object Name, LastWriteTime
    $diff = Compare-Object $previousFiles $currentFiles -Property Name, LastWriteTime

    # Check for added or deleted files
    $newFiles = $diff | Where-Object { $_.SideIndicator -eq "=>" }
    $deletedFiles = $diff | Where-Object { $_.SideIndicator -eq "<=" }

    # Trigger synchronization if there are changes or every 5 seconds (fallback)
    if ($deletedFiles -or $newFiles -or ($counter -ge 5)) {
        $scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

        # Prepare and run WinSCP with a predefined script
        $process = New-Object System.Diagnostics.ProcessStartInfo
        $process.FileName = "C:\Program Files (x86)\WinSCP\WinSCP.com"
        $process.Arguments = "/script:`"$scriptPath\sync_ftp.txt`""
        $process.UseShellExecute = $false
        $process.RedirectStandardOutput = $true
        $process.RedirectStandardError = $true
        $process.CreateNoWindow = $true

        [System.Diagnostics.Process]::Start($process).WaitForExit()

        Start-Sleep -Seconds 2
        $counter = 0
    }

    # Update reference for next comparison
    $previousFiles = $currentFiles
}
