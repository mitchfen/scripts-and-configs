$url = 'https://prices.runescape.wiki/api/v1/osrs/1h'

try {
    $latestPricesFile = Join-Path $PSScriptRoot "latestPrices.json"
    $herbsFile = Join-Path $PSScriptRoot "herbs.json"
    $numberOfHerbsPickedPerSeed = 8.56

    $headers = @{'User-Agent'='herb-prices-powershell-script'}
    $response = Invoke-WebRequest -Uri $url -Method GET -Headers $headers
    $response.Content | Out-File $latestPricesFile -Force

    $herbs = Get-Content $herbsFile -Raw | ConvertFrom-Json
    $latestPrices = $response.Content | ConvertFrom-Json

    foreach($herb in $herbs) {
        $herbPrices = $latestPrices.data.$($herb.Id)
        $seedPrices = $latestPrices.data.$($herb.SeedId)
        $herb.SeedPriceAverage = [int]$(($seedPrices.avgHighPrice + $seedPrices.avgLowPrice) / 2 )
        $herb.HighPriceAverage = $herbPrices.avgHighPrice
        $herb.LowPriceAverage = $herbPrices.avgLowPrice
        $herb.HerbPriceAverage = [int]$(($herbPrices.avgHighPrice + $herbPrices.avgLowPrice) / 2 )
        $herb.ExpectedProfit = [int]($herb.HerbPriceAverage * $numberOfHerbsPickedPerSeed) - $herb.SeedPriceAverage
    }
    Write-Host
    Write-Host "Here are the latest herb prices. This table assumes 8.56 herbs harvested per seed."
    $herbs | Sort-Object -Property ExpectedProfit -Descending | Format-Table Name, ExpectedProfit, SeedPriceAverage, HerbPriceAverage

} catch {
    $_
}
