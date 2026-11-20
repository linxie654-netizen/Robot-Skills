param(
    [Parameter(Mandatory = $true)][string]$Path,
    [ValidateSet('GET', 'POST')][string]$Method = 'GET',
    [string]$Body = "",
    [string]$BodyFile = ""
)
$ErrorActionPreference = 'Stop'
$base = 'http://127.0.0.1:58080'
# -BodyFile avoids Windows command-line quote mangling for JSON payloads. Prefer it for
# anything containing nested quotes when calling this script through powershell -File.
if ($BodyFile) { $Body = [System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $BodyFile).Path) }
try {
    if ($Method -eq 'POST') {
        if ($Body) {
            # Send explicit UTF-8 bytes so non-ASCII text is not dropped by PowerShell 5.1
            $res = Invoke-RestMethod "$base$Path" -Method POST -ContentType 'application/json' -Body ([System.Text.Encoding]::UTF8.GetBytes($Body)) -TimeoutSec 120
        } else {
            $res = Invoke-RestMethod "$base$Path" -Method POST -ContentType 'application/json' -Body '{}' -TimeoutSec 120
        }
    } else {
        $res = Invoke-RestMethod "$base$Path" -Method GET -TimeoutSec 60
    }
    $res | ConvertTo-Json -Depth 12
} catch {
    Write-Error "Bridge call failed: $($_.Exception.Message)"
    $r = $_.Exception.Response
    if ($r) {
        $sr = New-Object System.IO.StreamReader($r.GetResponseStream())
        Write-Host ("BODY: " + $sr.ReadToEnd())
    }
    exit 1
}
