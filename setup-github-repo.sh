#!/bin/bash

# GitHub Repository Setup Script
# Run this to initialize git and push to GitHub

set -e

echo "🚀 Voice-to-Tasks Automation - GitHub Setup"
echo "==========================================="
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git initialized"
else
    echo "✅ Git repository already initialized"
fi

# Check for sensitive files before committing
echo ""
echo "🔍 Checking for sensitive files..."

if [ -f ".env" ]; then
    echo "⚠️  Warning: .env file found - make sure it's in .gitignore"
fi

if grep -r "sk-proj-" . --exclude-dir=.git --exclude="*.sh" 2>/dev/null; then
    echo "⚠️  Warning: Possible API keys found in files!"
    echo "   Please review and remove before committing"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Add all files
echo ""
echo "📝 Staging files..."
git add .

# Create initial commit
echo ""
echo "💾 Creating initial commit..."
git commit -m "Initial commit: Voice-to-Tasks Automation System

- Project structure and documentation
- README with project overview
- Contributing guidelines and Code of Conduct
- Security policy
- GitHub issue/PR templates
- Core project files (sanitized)"

echo ""
echo "✅ Initial commit created!"
echo ""

# Get GitHub username
read -p "Enter your GitHub username: " GITHUB_USER

# Get repository name (default: vikunja-voice-automation)
read -p "Enter repository name [vikunja-voice-automation]: " REPO_NAME
REPO_NAME=${REPO_NAME:-vikunja-voice-automation}

# Set up remote
echo ""
echo "🔗 Setting up GitHub remote..."
git branch -M main
git remote add origin "https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo ""
echo "✅ Remote configured: https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""

# Ask if user wants to push now
read -p "Push to GitHub now? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "📤 Pushing to GitHub..."
    echo ""
    echo "Note: You may be prompted for GitHub credentials"
    echo "      Or set up SSH keys for easier access"
    echo ""
    
    git push -u origin main
    
    echo ""
    echo "✅ Pushed to GitHub!"
    echo ""
    echo "🎉 Your repository is live at:"
    echo "   https://github.com/${GITHUB_USER}/${REPO_NAME}"
    echo ""
else
    echo ""
    echo "⏳ Skipped push. When ready, run:"
    echo "   git push -u origin main"
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎊 GitHub repository setup complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo "  1. Visit your repository on GitHub"
echo "  2. Add a description and topics"
echo "  3. Configure repository settings"
echo "  4. Enable GitHub Discussions (optional)"
echo "  5. Set up branch protection rules (optional)"
echo ""
echo "Happy coding! 🚀"
echo ""

