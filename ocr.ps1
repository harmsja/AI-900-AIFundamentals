$key="YOUR_KEY"
$endpoint="YOUR_ENDPOINT"


# Code to call OCR service for text in image analysis

$img = "https://raw.githubusercontent.com/MicrosoftLearning/AI-900-AIFundamentals/main/data/vision/advert.jpg"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image...`n"
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/vision/v3.2/ocr?language=en&detectOrientation=true&model-version=latest" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 6

$analysis = ($result | ConvertFrom-Json)

foreach ($listofdict in $analysis.regions.lines.words)
{
    foreach($dict in $listofdict)
    {
        Write-Host ("Text:", $($dict.text), "| Text Bounding Box:", $($dict.boundingBox))
    }
}