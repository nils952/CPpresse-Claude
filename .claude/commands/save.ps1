# Claude save command - Commit and push to GitHub
param(
    [string]$message = "Update"
)

Write-Host "📦 Saving to GitHub..." -ForegroundColor Cyan

# Go to the project directory
$projectDir = "C:\Users\nilsm\Desktop\Projet Nils"
Push-Location $projectDir

try {
    # Add all changes
    Write-Host "Adding files..." -ForegroundColor Yellow
    git add .

    # Commit with message
    Write-Host "Committing with message: '$message'" -ForegroundColor Yellow
    git commit -m $message

    # Push to GitHub
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    git push

    Write-Host "✅ Done! Your changes are now on GitHub." -ForegroundColor Green
} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
} finally {
    Pop-Location
}
