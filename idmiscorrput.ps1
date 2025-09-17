$TituloDaJanela = "IDM is corrupt"
$IntervaloDeVerificacao = 2

$CSharpApi = @"
using System;
using System.Runtime.InteropServices;
public static class User32 {
    [DllImport("user32.dll", SetLastError = true)]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
}
public static class Kernel32 {
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern IntPtr OpenThread(uint desiredAccess, bool inheritHandle, uint threadId);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern bool TerminateThread(IntPtr hThread, uint exitCode);
    [DllImport("kernel32.dll", SetLastError=true)]
    public static extern bool CloseHandle(IntPtr handle);
}
"@

Try {
    Add-Type -TypeDefinition $CSharpApi -ErrorAction Stop
} Catch {
}

while ($true) {
    try {
        $processoAlvo = Get-Process -Name "IDMan" -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -eq $TituloDaJanela }

        if ($processoAlvo) {
            $hwnd = $processoAlvo.MainWindowHandle
            $processIdVar = 0
            $tid = [User32]::GetWindowThreadProcessId($hwnd, [ref]$processIdVar)

            if ($tid -ne 0) {
                $hThread = [Kernel32]::OpenThread(0x0001, $false, $tid)
                if ($hThread -ne [IntPtr]::Zero) {
                    [Kernel32]::TerminateThread($hThread, 0)
                    [Kernel32]::CloseHandle($hThread)
                }
            }
        }
    } Catch {
    }

    Start-Sleep -Seconds $IntervaloDeVerificacao
}
