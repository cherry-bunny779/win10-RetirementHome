# Recursively copies directory, skips file if 10s timeout.
# Outputs log of skipped files at destination dir.
#
# Known Issue: some files can be skipped as intended, but SSD in
# external enclosure idles for some corrupt files blocking execution

# Prompt user for Source and Destination
$Source = Read-Host "Enter the full path of the Source directory"
while (-not (Test-Path $Source -PathType Container)) {
    Write-Warning "Source path is invalid. Please try again."
    $Source = Read-Host "Enter the full path of the Source directory"
}

$Destination = Read-Host "Enter the full path of the Destination directory"
if (-not (Test-Path $Destination)) {
    Write-Host "Destination does not exist. Creating it..."
    New-Item -ItemType Directory -Path $Destination | Out-Null
}

# Timeout threshold for unresponsive file
$TimeoutSec  = 10
$LogFile     = Join-Path $Destination "unresponsive_files.log"

# Prepare log
"Unresponsive files:" | Out-File -Encoding UTF8 -FilePath $LogFile

Write-Host "`nCopying from $Source to $Destination"
Write-Host "Timeout for unresponsive file: $TimeoutSec seconds"
Write-Host

# Function to copy a single file with timeout monitoring
function Copy-With-Timeout {
    param (
        [string]$SrcFile,
        [string]$DstFile
    )

    $DstDir = Split-Path $DstFile
    if (-not (Test-Path $DstDir)) {
        New-Item -ItemType Directory -Path $DstDir -Force | Out-Null
    }

    Write-Host "Copying: $SrcFile"

    $Job = Start-Job -ScriptBlock {
        param($s, $d)
        Copy-Item -Path $s -Destination $d -Force
    } -ArgumentList $SrcFile, $DstFile

    $StartTime = Get-Date
    $LastSize  = -1

    while ($true) {
        Start-Sleep -Seconds 1

        if ($Job.State -eq "Completed") {
            Receive-Job $Job | Out-Null
            Remove-Job $Job
            break
        }

        if (Test-Path $DstFile) {
            $CurrentSize = (Get-Item $DstFile).Length
            if ($CurrentSize -ne $LastSize) {
                $LastSize = $CurrentSize
                $StartTime = Get-Date
            } else {
                $Elapsed = (Get-Date) - $StartTime
                if ($Elapsed.TotalSeconds -ge $TimeoutSec) {
                    Write-Warning "Unresponsive: $SrcFile"
                    Stop-Job $Job
                    Remove-Job $Job
                    Remove-Item $DstFile -ErrorAction SilentlyContinue
                    $SrcFile | Out-File -FilePath $LogFile -Append
                    break
                }
            }
        }
    }
}

# Process all files
Get-ChildItem -Path $Source -Recurse -File | ForEach-Object {
    $RelPath = $_.FullName.Substring($Source.Length).TrimStart('\')
    $TargetPath = Join-Path $Destination $RelPath
    Copy-With-Timeout -SrcFile $_.FullName -DstFile $TargetPath
}

Write-Host "`nAll done!"
Write-Host "Unresponsive files:"
Get-Content $LogFile
