Function Start-Journal {
  Set-Location ~/journal
  $todaysDate = $( Get-Date -Format "yyyy-MM-dd" )
  $fileName = $todaysDate + ".txt"
  $journalEntryNumber = (Get-ChildItem ~/journal | Measure-Object ).Count
  if ( !(Get-ChildItem -Filter "$todaysDate.txt") ) {
      Write-Output "---- Entry Number $journalEntryNumber" > $fileName
      Write-Output "---- Date $todaysDate" >> $fileName
  }

  vim "$fileName"
}
