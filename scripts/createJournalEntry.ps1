$journalDir = Join-Path $HOME "mindpalace/Journal"
if (!(Test-Path $journalDir)) {
  New-Item -Type Directory -Path $journalDir | Out-Null
}
Set-Location $journalDir
$todaysDate = Get-Date -Format "yyyy-MM-dd"
$yesterdaysDate = Get-Date (Get-Date).addDays(-1) -Format "yyyy-MM-dd"
$tomorrowsDate = Get-Date (Get-Date).addDays(1) -Format "yyyy-MM-dd"
$fileName = $todaysDate + ".md"
$journalEntryNumber = (Get-ChildItem $journalDir | Measure-Object ).Count
if ( !(Get-ChildItem -Filter $fileName) ) {
    Write-Output "Yesterday: [[ Journal/$yesterdaysDate ]]" > $fileName
    Write-Output "Tomorrow: [[ Journal/$tomorrowsDate ]]" >> $fileName
    Write-Output "Entry Number: $journalEntryNumber" >> $fileName
}

vim "$fileName"
