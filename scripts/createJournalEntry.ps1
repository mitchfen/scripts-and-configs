function Assert-Directory {
	param( [Parameter(Mandatory)][string]$DirectoryName )
	if (! (Test-Path $DirectoryName)) {
	  New-Item -Type Directory -Path $DirectoryName | Out-Null
	}
}

if ($env:OS -like "Windows*" ) {
	$journalDir = "/dev/obsidian-vault-mitchfen/Journal"
}
else {
	$journalDir = Join-Path $HOME "dev/obsidian-vault-mitchfen/Journal"
}

Assert-Directory -DirectoryName $journalDir
Set-Location $journalDir
$todaysDate = Get-Date
Assert-Directory -DirectoryName $($todaysDate.Year)
Set-Location $($todaysDate.Year)
$todaysDateAsString = Get-Date -Format "yyyy-MM-dd"
$fileName = $todaysDateAsString + ".md"
$journalEntryNumber = (Get-ChildItem $journalDir | Measure-Object ).Count
if ( !(Get-ChildItem -Filter $fileName) ) {
    Write-Output "[[ $($todaysDate.Year) ]]" >> $fileName
    Write-Output "Entry Number: $journalEntryNumber" >> $fileName
}

vim "$fileName"

