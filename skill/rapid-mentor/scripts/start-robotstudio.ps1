param(
    [string]$Station = "",
    [string]$Addin = ""
)
$ErrorActionPreference = 'Stop'
$exe = 'D:\Program Files (x86)\ABB Industrial IT\Robotics IT\RobotStudio 6.08\Bin64\RobotStudio.exe'
if (-not $Addin) {
    $Addin = if ($env:CLAUDEBRIDGE_ADDIN) { $env:CLAUDEBRIDGE_ADDIN } else { Join-Path $env:USERPROFILE 'RobotStudioBridge\ClaudeBridge.rsaddin' }
}

if (-not (Test-Path -LiteralPath $exe)) { Write-Error "RobotStudio not found: $exe"; exit 1 }
if (-not (Test-Path -LiteralPath $Addin)) { Write-Error "Add-In manifest not found: $Addin"; exit 1 }

try { $null = Invoke-RestMethod 'http://127.0.0.1:58080/ping' -TimeoutSec 2; Write-Host "Bridge already running"; exit 0 } catch { }

$cmd = '"{0}" /addin:"{1}"' -f $exe, $Addin
if ($Station) {
    if (-not (Test-Path -LiteralPath $Station)) { Write-Error "Station not found: $Station"; exit 1 }
    $cmd = $cmd + ' "' + $Station + '"'
}

# Detached launch — a plain Start-Process child gets reclaimed by the caller
$r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = $cmd }
if ($r.ReturnValue -ne 0) { Write-Error "Win32_Process.Create failed: $($r.ReturnValue)"; exit 1 }
Write-Host "Launched RobotStudio pid=$($r.ProcessId)"

for ($i = 1; $i -le 40; $i++) {
    Start-Sleep -Seconds 5
    try {
        $p = Invoke-RestMethod 'http://127.0.0.1:58080/ping' -TimeoutSec 2
        if ($p.stationOpen -or -not $Station) {
            Write-Host ("Bridge ready: stationOpen={0} stationName={1}" -f $p.stationOpen, $p.stationName)
            exit 0
        }
    } catch { }
}
Write-Error "Timed out waiting for bridge on 127.0.0.1:58080"
exit 1
