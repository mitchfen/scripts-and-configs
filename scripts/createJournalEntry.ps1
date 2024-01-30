$journalDir = Join-Path $HOME journal
if (!(Test-Path $journalDir)) {
  New-Item -Type Directory -Path $journalDir | Out-Null
}
Set-Location $journalDir
$todaysDate = $( Get-Date -Format "yyyy-MM-dd" )
$fileName = $todaysDate + ".txt"
$journalEntryNumber = (Get-ChildItem $journalDir | Measure-Object ).Count
if ( !(Get-ChildItem -Filter "$todaysDate.txt") ) {
    Write-Output "---- Entry Number $journalEntryNumber" > $fileName
    Write-Output "---- Date $todaysDate" >> $fileName
}

vim "$fileName"
