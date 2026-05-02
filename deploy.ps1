$ErrorActionPreference = "Stop"

# Get token from git credential manager
$lines = (echo "protocol=https`nhost=github.com`n" | git credential fill) -split "`n"
$token = ""
foreach($l in $lines) { if($l -match "^password=(.*)") { $token = $matches[1] } }
$headers = @{ 
    Authorization = "Bearer $token"
    Accept = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

Write-Host "Creating GitHub Release v1.0.0..."
$releaseBody = @{
    tag_name = "v1.0.0"
    target_commitish = "nivra-main"
    name = "Nivra v1.0.0"
    body = "First official Nivra release. Lavender Material You theme, custom branding, native OTA updater."
} | ConvertTo-Json

$releaseRes = Invoke-RestMethod -Method Post -Uri "https://api.github.com/repos/emperor-777/Nivra/releases" -Headers $headers -Body $releaseBody -ContentType "application/json"
$uploadUrl = $releaseRes.upload_url -replace '\{.*\}',''
$releaseId = $releaseRes.id
Write-Host "Release created with ID: $releaseId"

$apkPath = "app\build\outputs\apk\nivraProd\debug\Signal-Android-nivra-prod-universal-debug-8.9.0.apk"
$apkName = "Signal-Android-nivra-prod-universal-debug-8.9.0.apk"
$uploadUri = "$($uploadUrl)?name=$apkName"

Write-Host "Uploading APK (745MB) to release... This will take a few minutes."
Invoke-RestMethod -Method Post -Uri $uploadUri -Headers $headers -InFile $apkPath -ContentType "application/vnd.android.package-archive" -TimeoutSec 1800 | Out-Null
Write-Host "APK uploaded successfully."

Write-Host "Enabling GitHub Pages..."
try {
    $pagesBody = @{
        source = @{
            branch = "gh-pages"
            path = "/"
        }
    } | ConvertTo-Json
    Invoke-RestMethod -Method Post -Uri "https://api.github.com/repos/emperor-777/Nivra/pages" -Headers $headers -Body $pagesBody -ContentType "application/json" | Out-Null
    Write-Host "GitHub Pages enabled successfully."
} catch {
    Write-Host "Failed to enable GitHub Pages automatically. Error: $_"
}

Write-Host "Deployment complete!"
