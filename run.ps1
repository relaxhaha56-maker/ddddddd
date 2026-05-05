$AppScriptUrl = "https://script.google.com/macros/s/AKfycbzV6BvSVGjGQg5afthgYjd-RL5DYtoMqel7QdR85EhpTsPsT1ymtkRs4tylpMig17HAlA/exec"
$GitHubRawUrl = "https://raw.githubusercontent.com/relaxhaha56-maker/ddddddd/refs/heads/main/data.txt"

Clear-Host
$UserKey = Read-Host "Enter License Key"
$DeviceUUID = (Get-CimInstance Win32_ComputerSystemProduct).UUID

Write-Host "Verifying..." -ForegroundColor Cyan
$Response = Invoke-RestMethod -Uri "$($AppScriptUrl)?key=$($UserKey)&hwid=$($DeviceUUID)"

if ($Response -eq "success") {
    Write-Host "Access Granted!" -ForegroundColor Green
    
    $Base64String = Invoke-RestMethod -Uri $GitHubRawUrl
    
    $Bytes = [System.Convert]::FromBase64String($Base64String)
    $TempPath = "$env:TEMP\sys_cache_$(Get-Random).dll"
    [System.IO.File]::WriteAllBytes($TempPath, $Bytes)

    Write-Host "Loading AimbotFemaleFix..." -ForegroundColor Yellow

    # Start-Process "your_injector.exe" -ArgumentList "-p HD-Player.exe -d $TempPath" -Wait

    Start-Sleep -Seconds 3 
    if (Test-Path $TempPath) {
        Remove-Item -Path $TempPath -Force
        Write-Host "Cleanup completed. System is Secured." -ForegroundColor Gray
    }
} else {
    Write-Host "Access Denied! Check your Key or HWID." -ForegroundColor Red
    pause
}