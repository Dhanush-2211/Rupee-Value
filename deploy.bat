@echo off
REM Rupee Value Tracker - Automated Deployment Script for Windows

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║     🚀 RUPEE VALUE TRACKER - DEPLOYMENT ASSISTANT 🚀          ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git is not installed. Please install Git first:
    echo    Download from: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✓ Git is installed
echo.

REM Get user information
set /p github_username="📧 Enter your GitHub username (e.g., john123): "
set /p github_email="📧 Enter your GitHub email: "
set /p github_token="🔑 Enter your GitHub Personal Access Token (or press Enter to use HTTPS password): "

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║               ⚙️  CONFIGURING REPOSITORY ⚙️                   ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Configure git
git config --global user.name "%github_username%"
git config --global user.email "%github_email%"

echo ✓ Git configured
echo.

REM Create repository URL
if "%github_token%"=="" (
    set REPO_URL=https://github.com/%github_username%/rupee-value-tracker.git
    echo ℹ️  Using HTTPS - you'll be prompted for password
) else (
    set REPO_URL=https://%github_username%:%github_token%@github.com/%github_username%/rupee-value-tracker.git
    echo ℹ️  Using HTTPS with Personal Access Token
)

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║              📋 NEXT STEPS ON GITHUB (MANUAL) 📋              ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.
echo Before continuing, you MUST create a repository on GitHub:
echo.
echo 1. Go to: https://github.com/new
echo 2. Repository name: rupee-value-tracker
echo 3. Visibility: Public
echo 4. Click 'Create repository'
echo.
pause /b

echo.
echo ╔════════════════════════════════════════════════════════════════╗
echo ║                  🚀 PUSHING TO GITHUB 🚀                      ║
echo ╚════════════════════════════════════════════════════════════════╝
echo.

REM Add remote
echo Adding GitHub as remote repository...
git remote add origin "%REPO_URL%"

if errorlevel 1 (
    echo ❌ Remote already exists. Updating...
    git remote set-url origin "%REPO_URL%"
)

echo ✓ Remote repository configured
echo.

REM Rename branch to main
git branch -M main

REM Push to GitHub
echo Pushing code to GitHub...
git push -u origin main

if errorlevel 0 (
    echo.
    echo ✓ Code pushed successfully!
    echo.
    echo ╔════════════════════════════════════════════════════════════════╗
    echo ║              ⚙️  ENABLE GITHUB PAGES (MANUAL) ⚙️               ║
    echo ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo Now you need to enable GitHub Pages:
    echo.
    echo 1. Go to: https://github.com/%github_username%/rupee-value-tracker
    echo 2. Click 'Settings' (top of the page^)
    echo 3. Click 'Pages' (left sidebar^)
    echo 4. Under 'Source', select 'Deploy from a branch'
    echo 5. Select branch: 'main'
    echo 6. Select folder: '/ (root^)'
    echo 7. Click 'Save'
    echo.
    echo ✓ Wait 1-2 minutes for deployment
    echo.
    echo ╔════════════════════════════════════════════════════════════════╗
    echo ║                  ✅ YOUR WEBSITE IS LIVE! ✅                   ║
    echo ╚════════════════════════════════════════════════════════════════╝
    echo.
    echo 🌐 Visit your site at:
    echo    https://%github_username%.github.io/rupee-value-tracker
    echo.
    echo 📱 Share this URL with anyone - your website is now LIVE!
    echo.
) else (
    echo ❌ Error pushing to GitHub
    echo Check your credentials and try again
)

pause
