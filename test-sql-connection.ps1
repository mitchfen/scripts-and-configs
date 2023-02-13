[CmdletBinding()]
param(
  [Parameter(Mandatory)][string]$connectionString
)

try {
  $sqlConn = New-Object System.Data.SqlClient.SqlConnection
  $sqlConn.ConnectionString = $connectionString
  Write-Host "Attempting to open a connection..."
  $sqlConn.Open()
  Write-Host "Connection opened successfully."
  $sqlConn.Close()
  Write-Host "Connection closed successfully."
} catch {
  $_
}
