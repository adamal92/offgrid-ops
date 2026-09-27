# setup-env.ps1 - Auto-Onboarding for TaktiKIT/OffGridOps
Write-Host "🚀 Setting up TaktiKIT Dev Environment..." -ForegroundColor Green

# 1. Ensure Execution Policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# 2. Copy profile setup if needed
$TargetProfile = $PROFILE
$SourceProfile = Join-Path $PSScriptRoot "Microsoft.PowerShell_profile.ps1"

if (Test-Path $SourceProfile) {
    Copy-Item -Path $SourceProfile -Destination $TargetProfile -Force
    Write-Host "✅ PowerShell profile configured." -ForegroundColor Green
}

# 3. Trigger FNM & Install Dependencies
fnm use
pnpm install

Write-Host "🎉 Environment setup complete! You are ready to build." -ForegroundColor Cyan