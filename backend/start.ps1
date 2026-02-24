# HRMS Backend Starter Script
Write-Host "🚀 Starting HRMS Backend Server..." -ForegroundColor Cyan
Write-Host ""

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host "⚠️  .env file not found!" -ForegroundColor Yellow
    Write-Host "Please create a .env file with your database credentials." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Example .env file:" -ForegroundColor Green
    Write-Host "DB_HOST=localhost"
    Write-Host "DB_USER=root"
    Write-Host "DB_PASSWORD=your_password"
    Write-Host "DB_NAME=HRMS_Project"
    Write-Host "PORT=5000"
    Write-Host ""
    exit 1
}

# Start the server
Write-Host "✓ .env file found" -ForegroundColor Green
Write-Host "Starting server on port 5000..." -ForegroundColor Cyan
Write-Host ""

npm start
