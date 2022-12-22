param(
    [switch]$Start,
    [switch]$Stop
)

$services = @('MSSQLSERVER', 'SQLWriter')

foreach ($service in $services) {
    if ($Stop) {
        Write-Host "Stopping $service..." -NoNewLine
        Stop-Service $service
        Write-Host " Done."
    }
    if ($Start) {
        Write-Host "Starting $service..." -NoNewLine
        Start-Service $service
        Write-Host " Done."
    }
}
