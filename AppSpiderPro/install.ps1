<powershell>
function InstallExe {
    
    $uri = "http://download2.rapid7.com/download/AppSpider/AppSpiderFullSetup.exe"
    $desktop = "$env:USERPROFILE\Desktop"
    $asp = "$desktop\AppSpiderFullSetup.exe"
    Invoke-WebRequest -Uri $uri -OutFile $asp
    & $asp /S install /UI /CMD
}

# Attempt to download installer
InstallExe
$attempts = 0
$count - 0
while (!(Get-Item "$desktop\install.log")) {
    Write-Output "Inside log counter lop: $count" >> "$desktop\installer.log"
    $count ++
    if ($attempts -eq 3) {
        Write-Output "Failed to download installer" > "$desktop\download.log"
        Restart-Computer
    }
    InstallExe
    $attempts ++
}

$count = 0
# Loop until program has been installed
while ($true)
{
    Write-Output "Inside software install check loop: $count" >> "$desktop\installer.log"
    if((Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | Where-Object {$_.DisplayName -like "*appspider*"}))
    {
        Restart-Computer -Force
    }
}
</powershell>

