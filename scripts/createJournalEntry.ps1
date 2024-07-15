function Assert-Directory {
	param( [Parameter(Mandatory)][string]$DirectoryName )
	if (! (Test-Path $DirectoryName)) {
	  New-Item -Type Directory -Path $DirectoryName | Out-Null
	}
}

if ($env:OS -like "Windows*" ) {
	$journalDir = "/dev/mitchfen-vault/Journal"
}
else {
	$journalDir = Join-Path $HOME "dev/mitchfen-vault/Journal"
}
Assert-Directory -DirectoryName $journalDir
Set-Location $journalDir

$todaysDate = Get-Date
$todaysDateAsString = Get-Date -Format "yyyy-MM-dd"
$fileName = "Journal-" + $todaysDateAsString + ".md"
if ( !(Get-ChildItem -Filter $fileName) ) {
    Write-Output "[[ Journal/$($todaysDate.Year) ]]" >> $fileName
}

vim "$fileName"

