# Script to run FastAPI backend with hot reloading on Windows

Write-Host "Starting InterviewHire FastAPI Backend on Port 8001..." -ForegroundColor Green
Set-Location -Path "$PSScriptRoot\backend"

if (Test-Path "venv\Scripts\Activate.ps1") {
    . venv\Scripts\Activate.ps1
}

uvicorn main:app --reload --port 8000
