Add-Type @"
using System;using System.Text;using System.Runtime.InteropServices;
public class RsFixWindow {
 [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWindowsProc cb, IntPtr l);
 public delegate bool EnumWindowsProc(IntPtr h, IntPtr l);
 [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
 [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint p);
 [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int c);
 [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr h, IntPtr a, int x, int y, int cx, int cy, uint f);
 [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
}
"@
$proc = Get-Process RobotStudio -ErrorAction SilentlyContinue | Select-Object -First 1
if (-not $proc) { Write-Error "RobotStudio is not running"; exit 1 }

$script:hwnd = [IntPtr]::Zero
[RsFixWindow]::EnumWindows({ param($h, $l)
    $p = 0; [void][RsFixWindow]::GetWindowThreadProcessId($h, [ref]$p)
    if ($p -eq $proc.Id) {
        $t = New-Object System.Text.StringBuilder 512
        [void][RsFixWindow]::GetWindowText($h, $t, 512)
        if ($t.ToString() -like '*RobotStudio*') { $script:hwnd = $h }
    }
    return $true }, [IntPtr]::Zero) | Out-Null

if ($script:hwnd -eq [IntPtr]::Zero) { Write-Error "RobotStudio main window not found"; exit 1 }
[void][RsFixWindow]::ShowWindow($script:hwnd, 9)
Start-Sleep -Milliseconds 400
[void][RsFixWindow]::SetWindowPos($script:hwnd, [IntPtr]::Zero, 0, 0, 1270, 770, 0x0040)
[void][RsFixWindow]::SetForegroundWindow($script:hwnd)
Start-Sleep -Milliseconds 600
Write-Host "Window restored to 1270x770"
