$key="b275c27290914e8483d58854b59d869f"
$endpoint="https://cogserv-demo.cognitiveservices.azure.com/"

# Code to call Face service for face detection

$img = "https://raw.githubusercontent.com/MicrosoftLearning/AI-900-AIFundamentals/main/data/vision/store-camera-1.jpg"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image...`n"
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/face/v1.0/detect?detectionModel=detection_01&returnFaceId=true&returnFaceAttributes=age,smile,facialHair,glasses,emotion,hair,makeup,accessories" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = ($result | ConvertFrom-Json)
foreach ($face in $analysis)
{
    Write-Host("Face location: $($face.faceRectangle)`n - Age:$($face.faceAttributes.age)`n - Emotions: $($face.faceAttributes.emotion)`n")
}
