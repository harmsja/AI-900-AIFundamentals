$predictionUrl="https://cogserv-demo.cognitiveservices.azure.com/"
$predictionKey = "b275c27290914e8483d58854b59d869f"

# Code to call Custom Vision service for image detection

$img = "https://raw.githubusercontent.com/MicrosoftLearning/AI-900-AIFundamentals/main/data/vision/produce.jpg"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $predictionKey )
$headers.Add( "Prediction-Key", $predictionKey )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri "$predictionUrl/vision/v3.2/detect" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$prediction = $result | ConvertFrom-Json

write-host $prediction

$items = $prediction.predictions

foreach ($item in $items) 
{if ($item.probability -gt .9)
{
    Write-Host ("`n",$item.tagName, "`n")
}
}

