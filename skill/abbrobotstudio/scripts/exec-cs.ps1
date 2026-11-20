param([Parameter(Mandatory = $true)][string]$File)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $File)) { Write-Error "Code file not found: $File"; exit 1 }

# ReadAllText returns a plain string with BOM detection. Get-Content -Raw carries PSPath
# note properties, and ConvertTo-Json would serialize the whole object instead of the code.
$resolved = (Resolve-Path -LiteralPath $File).Path
$code = [System.IO.File]::ReadAllText($resolved)
$payload = @{ code = $code; timeout = 600 } | ConvertTo-Json -Depth 4
# Invoke-RestMethod sends a string body as ASCII in PowerShell 5.1, which drops non-ASCII
# characters in the snippet. Send explicit UTF-8 bytes instead.
$bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)

try {
    $res = Invoke-RestMethod 'http://127.0.0.1:58080/exec' -Method POST -ContentType 'application/json' -Body $bytes -TimeoutSec 620
    $res | ConvertTo-Json -Depth 12
} catch {
    Write-Error "exec failed: $($_.Exception.Message)"
    $r = $_.Exception.Response
    if ($r) {
        $sr = New-Object System.IO.StreamReader($r.GetResponseStream())
        Write-Host ("BODY: " + $sr.ReadToEnd())
    }
    exit 1
}
