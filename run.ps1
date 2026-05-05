$AppScriptUrl = "https://script.google.com/macros/s/AKfycbzV6BvSVGjGQg5afthgYjd-RL5DYtoMqel7QdR85EhpTsPsT1ymtkRs4tylpMig17HAlA/exec"
$GitHubRawUrl = "https://raw.githubusercontent.com/relaxhaha56-maker/ddddddd/refs/heads/main/data.txt"

Clear-Host
Write-Host "=============================="
$UserKey = Read-Host "Enter License Key"
Write-Host "=============================="

$DeviceUUID = (Get-CimInstance Win32_ComputerSystemProduct).UUID
$FullUrl = $AppScriptUrl + "?key=" + $UserKey + "&hwid=" + $DeviceUUID

Write-Host "Checking..."
$Response = Invoke-RestMethod -Uri $FullUrl -Method Get

if ($Response -eq "success") {
    Write-Host "Access Granted!" -ForegroundColor Green
    $Base64String = Invoke-RestMethod -Uri $GitHubRawUrl
    $Bytes = [System.Convert]::FromBase64String($Base64String)
    $TempPath = "$env:TEMP\sys_cache.dll"
    [System.IO.File]::WriteAllBytes($TempPath, $Bytes)
    Write-Host "DLL Loaded. Cleaning up..."
    Start-Sleep -Seconds 2
    if (Test-Path $TempPath) { Remove-Item $TempPath -Force }
} else {
    Write-Host "Access Denied!" -ForegroundColor Red
    pause
}
