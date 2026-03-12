[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$ConnectionString
)

try {
  $ErrorActionPreference = "Stop"
  $sqlConn = New-Object System.Data.SqlClient.SqlConnection
  $sqlConn.ConnectionString = $ConnectionString
  Write-Host "Attempting to open a connection..."
  $sqlConn.Open()
  Write-Host "Connection opened successfully."
  $sqlConn.Close()
  Write-Host "Connection closed successfully."
} catch {
  Write-Error $_
}
