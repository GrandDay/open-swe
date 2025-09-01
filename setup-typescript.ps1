# TypeScript Upgrade and Installation Script for OpenSWE-Source
# Run this script in PowerShell

Write-Host "🚀 TypeScript Setup for OpenSWE-Source" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

$projectPath = "d:\local git 2025\cue-verse-beginnings\local main v1 - pre branch merge completion\Priv-cue-staging\ai-stack\openswe-source"
Set-Location $projectPath

Write-Host "📍 Working directory: $projectPath" -ForegroundColor Yellow

# Function to check if running as administrator
function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Method selection
Write-Host "`n🔧 Choose installation method:" -ForegroundColor Green
Write-Host "1. Enable Corepack + Yarn 3.5.1 (Recommended)" -ForegroundColor White
Write-Host "2. Use NPM (Alternative)" -ForegroundColor White
Write-Host "3. Use Global Yarn 1.x (Fallback)" -ForegroundColor White

$choice = Read-Host "Enter your choice (1-3)"

switch ($choice) {
    "1" {
        Write-Host "`n🔑 Checking administrator privileges..." -ForegroundColor Yellow
        if (-not (Test-Administrator)) {
            Write-Host "❌ Administrator privileges required for corepack enable" -ForegroundColor Red
            Write-Host "Please restart PowerShell as Administrator and run:" -ForegroundColor Yellow
            Write-Host "corepack enable" -ForegroundColor Cyan
            Write-Host "Then run this script again." -ForegroundColor Yellow
            Read-Host "Press Enter to exit"
            exit 1
        }
        
        Write-Host "✅ Running as Administrator" -ForegroundColor Green
        Write-Host "🔧 Enabling corepack..." -ForegroundColor Yellow
        try {
            corepack enable
            Write-Host "✅ Corepack enabled successfully" -ForegroundColor Green
            
            Write-Host "📦 Installing dependencies with Yarn 3.5.1..." -ForegroundColor Yellow
            yarn install
            
            Write-Host "🔨 Building project..." -ForegroundColor Yellow
            yarn build
            
            Write-Host "✅ TypeScript setup complete!" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ Error with corepack setup: $_" -ForegroundColor Red
            Write-Host "Falling back to NPM method..." -ForegroundColor Yellow
            & $MyInvocation.MyCommand.Path "2"
        }
    }
    
    "2" {
        Write-Host "`n📦 Using NPM installation method..." -ForegroundColor Yellow
        
        # Remove yarn-specific files if they exist
        if (Test-Path "yarn.lock") {
            Write-Host "🗑️ Removing yarn.lock..." -ForegroundColor Yellow
            Remove-Item "yarn.lock" -Force
        }
        
        Write-Host "📥 Installing dependencies with NPM..." -ForegroundColor Yellow
        npm install --legacy-peer-deps
        
        Write-Host "🔨 Building project..." -ForegroundColor Yellow
        npm run build
        
        Write-Host "✅ TypeScript setup complete with NPM!" -ForegroundColor Green
    }
    
    "3" {
        Write-Host "`n📦 Using global Yarn 1.x..." -ForegroundColor Yellow
        
        # Check if yarn is installed globally
        try {
            $yarnVersion = yarn --version
            Write-Host "📋 Global Yarn version: $yarnVersion" -ForegroundColor Yellow
        }
        catch {
            Write-Host "❌ Yarn not found. Installing globally..." -ForegroundColor Red
            npm install -g yarn
        }
        
        Write-Host "📥 Installing dependencies with global Yarn..." -ForegroundColor Yellow
        yarn install
        
        Write-Host "🔨 Building project..." -ForegroundColor Yellow
        yarn build
        
        Write-Host "✅ TypeScript setup complete with Yarn!" -ForegroundColor Green
    }
    
    default {
        Write-Host "❌ Invalid choice. Please run the script again." -ForegroundColor Red
        exit 1
    }
}

# Verify installation
Write-Host "`n🔍 Verifying TypeScript installation..." -ForegroundColor Yellow

try {
    if ($choice -eq "2") {
        $tsVersion = npx tsc --version
    } else {
        $tsVersion = yarn tsc --version
    }
    Write-Host "✅ TypeScript version: $tsVersion" -ForegroundColor Green
}
catch {
    Write-Host "⚠️ Could not verify TypeScript installation" -ForegroundColor Yellow
}

Write-Host "`n🎉 Setup complete! Your OpenSWE-Source project now has:" -ForegroundColor Green
Write-Host "   • TypeScript 5.9.2 (latest stable)" -ForegroundColor White
Write-Host "   • Modern ES2021+ configuration" -ForegroundColor White
Write-Host "   • Strict type checking enabled" -ForegroundColor White
Write-Host "   • All packages updated" -ForegroundColor White

Write-Host "`n📚 Next steps:" -ForegroundColor Cyan
Write-Host "   • Run development server: yarn dev" -ForegroundColor White
Write-Host "   • Type check: yarn lint" -ForegroundColor White
Write-Host "   • Format code: yarn format" -ForegroundColor White
Write-Host "   • Run tests: yarn test" -ForegroundColor White

Read-Host "`nPress Enter to exit"
