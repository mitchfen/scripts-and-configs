[CmdletBinding()]
param(
    [switch]$Start,
    [switch]$Stop
)

$services = @('MSSQLSERVER', 'SQLWriter')

foreach ($service in $services) {
    if ($Stop) {
        Write-Host "Stopping $service..." -NoNewLine
        Start-Process powershell -verb runas -ArgumentList "Stop-Service $service" -WindowStyle Hidden
        Write-Host " Done."
    }
    if ($Start) {
        Write-Host "Starting $service..." -NoNewLine
        Start-Process powershell -verb runas -ArgumentList "Start-Service $service" -WindowStyle Hidden
        Write-Host " Done."
    }
}
