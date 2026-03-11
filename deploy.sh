#!/bin/bash
# Rupee Value Tracker - Automated Deployment Script
# This script helps deploy the website to GitHub Pages

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     🚀 RUPEE VALUE TRACKER - DEPLOYMENT ASSISTANT 🚀          ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first:"
    echo "   Windows: https://git-scm.com/download/win"
    echo "   macOS: https://git-scm.com/download/mac"
    echo "   Linux: sudo apt-get install git"
    exit 1
fi

echo "✓ Git is installed"
echo ""

# Get user information
read -p "📧 Enter your GitHub username (e.g., john123): " github_username
read -p "📧 Enter your GitHub email (must match your account): " github_email
read -p "🔑 Enter your GitHub Personal Access Token (or press Enter to use SSH): " github_token

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║               ⚙️  CONFIGURING REPOSITORY ⚙️                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Configure git
git config --global user.name "$github_username"
git config --global user.email "$github_email"

echo "✓ Git configured"
echo ""

# Create repository URL
if [ -z "$github_token" ]; then
    REPO_URL="git@github.com:$github_username/rupee-value-tracker.git"
    echo "ℹ️  Using SSH (you'll need SSH keys set up)"
else
    REPO_URL="https://$github_username:$github_token@github.com/$github_username/rupee-value-tracker.git"
    echo "ℹ️  Using HTTPS with Personal Access Token"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              📋 NEXT STEPS ON GITHUB (MANUAL) 📋              ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Before continuing, you MUST create a repository on GitHub:"
echo ""
echo "1. Go to: https://github.com/new"
echo "2. Repository name: rupee-value-tracker"
echo "3. Visibility: Public"
echo "4. Click 'Create repository'"
echo ""
read -p "✓ Press Enter when you've created the repository on GitHub..."
echo ""

# Add remote
echo "Adding GitHub as remote repository..."
git remote add origin "$REPO_URL"

if [ $? -eq 0 ]; then
    echo "✓ Remote repository added"
else
    echo "❌ Error adding remote. Trying to update existing remote..."
    git remote set-url origin "$REPO_URL"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                  🚀 PUSHING TO GITHUB 🚀                      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
echo "Pushing code to GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo "✓ Code pushed successfully!"
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║              ⚙️  ENABLE GITHUB PAGES (MANUAL) ⚙️               ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Now you need to enable GitHub Pages:"
    echo ""
    echo "1. Go to: https://github.com/$github_username/rupee-value-tracker"
    echo "2. Click 'Settings' (top of the page)"
    echo "3. Click 'Pages' (left sidebar)"
    echo "4. Under 'Source', select 'Deploy from a branch'"
    echo "5. Select branch: 'main'"
    echo "6. Select folder: '/ (root)'"
    echo "7. Click 'Save'"
    echo ""
    echo "✓ Wait 1-2 minutes for deployment"
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                  ✅ YOUR WEBSITE IS LIVE! ✅                   ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🌐 Visit your site at:"
    echo "   https://$github_username.github.io/rupee-value-tracker"
    echo ""
    echo "📱 Share this URL with anyone - your website is now LIVE!"
    echo ""
else
    echo "❌ Error pushing to GitHub"
    echo "Check your credentials and try again"
    exit 1
fi
