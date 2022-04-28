$key="YOUR_KEY"
$endpoint="YOUR_ENDPOINT"

# Code to call Computer Vision service for image analysis

if ($args.count -gt 0)
{
    $img_file = $args[0]
} else {
    $img_file = "https://raw.githubusercontent.com/harmsja/AI-900-AIFundamentals/main/data/vision/store-camera-1.jpg"
}
write-host "Image URL: "
write-host $img_file

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/vision/v3.2/analyze?visualFeatures=Categories,Description,Objects" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = $result | ConvertFrom-Json
Write-Host("`nDescription:")
foreach ($caption in $analysis.description.captions)
{
    Write-Host ($caption.text)
}

Write-Host("`nObjects in this image:")
foreach ($object in $analysis.objects)
{
    Write-Host (" -", $object.object)
}

Write-Host("`nTags relevant to this image:")
foreach ($tag in $analysis.description.tags)
{
    Write-Host (" -", $tag)
}

Write-Host("`n")
