[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$AppScriptUrl = "https://script.google.com/macros/s/AKfycbzV6BvSVGjGQg5afthgYjd-RL5DYtoMqel7QdR85EhpTsPsT1ymtkRs4tylpMig17HAlA/exec"
$GitHubRawUrl = "https://raw.githubusercontent.com/relaxhaha56-maker/ddddddd/refs/heads/main/data.txt"

Clear-Host
Write-Host "==============================" -ForegroundColor White
$UserKey = Read-Host "  Enter License Key "
Write-Host "==============================" -ForegroundColor White

$DeviceUUID = (Get-CimInstance Win32_ComputerSystemProduct).UUID

Write-Host "Verifying..." -ForegroundColor Cyan

$FullUrl = $AppScriptUrl + "?key=" + $UserKey + "&hwid=" + $DeviceUUID

try {
    $Response = Invoke-RestMethod -Uri $FullUrl -Method Get
} catch {
    Write-Host "Error: Cannot connect to Server!" -ForegroundColor Red
    pause
    exit
}

if ($Response -eq "success") {
    Write-Host "Access Granted!" -ForegroundColor Green
    
    try {
        $Base64String = Invoke-RestMethod -Uri $GitHubRawUrl
        
        $Bytes = [System.Convert]::FromBase64String($Base64String)
        $TempPath = "$env:TEMP\sys_cache_$(Get-Random).dll"
        [System.IO.File]::WriteAllBytes($TempPath, $Bytes)

        Write-Host "Loading AimbotFemaleFix..." -ForegroundColor Yellow

        Start-Sleep -Seconds 3 
        if (Test-Path $TempPath) {
            Remove-Item -Path $TempPath -Force
            Write-Host "Cleanup completed. System is Secured." -ForegroundColor Gray
        }
    } catch {
        Write-Host "Error: Failed to process DLL data!" -ForegroundColor Red
    }
} else {
    Write-Host "Access Denied! Check your Key or HWID." -ForegroundColor Red
    pause
}
