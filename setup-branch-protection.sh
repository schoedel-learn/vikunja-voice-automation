#!/bin/bash

# GitHub Branch Protection Setup Script
# This script configures branch protection rules via GitHub API

set -e

echo "🛡️ GitHub Branch Protection Setup"
echo "=================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if GitHub CLI is installed
if command -v gh &> /dev/null; then
    echo -e "${GREEN}✅ GitHub CLI found!${NC}"
    echo "Using 'gh' for authentication"
    USE_GH=true
else
    echo -e "${YELLOW}⚠️  GitHub CLI not found${NC}"
    echo "Will use Personal Access Token instead"
    USE_GH=false
fi

echo ""

# Get GitHub credentials
if [ "$USE_GH" = true ]; then
    echo "Checking GitHub CLI authentication..."
    if gh auth status &> /dev/null; then
        echo -e "${GREEN}✅ Already authenticated with GitHub CLI${NC}"
        GITHUB_USER=$(gh api user --jq .login)
        echo "Logged in as: $GITHUB_USER"
    else
        echo ""
        echo "Please authenticate with GitHub CLI:"
        gh auth login
        GITHUB_USER=$(gh api user --jq .login)
    fi
else
    echo "We need a GitHub Personal Access Token with 'repo' permissions"
    echo ""
    echo "To create one:"
    echo "1. Go to: https://github.com/settings/tokens/new"
    echo "2. Name it: 'Branch Protection Setup'"
    echo "3. Check: 'repo' (Full control of private repositories)"
    echo "4. Click: 'Generate token'"
    echo "5. Copy the token"
    echo ""
    read -p "Enter your GitHub username: " GITHUB_USER
    read -sp "Enter your GitHub Personal Access Token: " GITHUB_TOKEN
    echo ""
    echo ""
fi

# Function to set branch protection
setup_protection() {
    local REPO=$1
    local OWNER=$2
    
    echo ""
    echo -e "${BLUE}🔧 Setting up protection for: ${OWNER}/${REPO}${NC}"
    echo ""
    
    # Protection settings JSON
    read -r -d '' PROTECTION_JSON << 'EOF' || true
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_linear_history": false,
  "required_conversation_resolution": false
}
EOF

    # Make API call
    if [ "$USE_GH" = true ]; then
        # Using GitHub CLI
        echo "$PROTECTION_JSON" | gh api \
            -X PUT \
            -H "Accept: application/vnd.github+json" \
            "/repos/${OWNER}/${REPO}/branches/main/protection" \
            --input -
    else
        # Using curl with token
        curl -s -X PUT \
            -H "Authorization: token ${GITHUB_TOKEN}" \
            -H "Accept: application/vnd.github+json" \
            -d "$PROTECTION_JSON" \
            "https://api.github.com/repos/${OWNER}/${REPO}/branches/main/protection"
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Protection enabled for ${REPO}!${NC}"
        echo ""
        echo "Protection settings:"
        echo "  ✅ Force pushes: BLOCKED"
        echo "  ✅ Branch deletion: BLOCKED"
        echo "  ℹ️  Admins can still bypass these rules"
    else
        echo -e "${RED}❌ Failed to set protection for ${REPO}${NC}"
        echo "This might be because:"
        echo "  - Repository doesn't exist yet"
        echo "  - You don't have admin permissions"
        echo "  - Token doesn't have 'repo' scope"
    fi
}

# Setup for emiliokofficial-laravel
echo ""
read -p "Set up branch protection for emiliokofficial-laravel? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    setup_protection "emiliokofficial-laravel" "schoedel-learn"
fi

# Setup for vikunja-voice-automation
echo ""
read -p "Set up branch protection for vikunja-voice-automation? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Enter the repository owner (your GitHub username): " VOICE_OWNER
    setup_protection "vikunja-voice-automation" "$VOICE_OWNER"
fi

# Optional: Setup with stricter rules
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -p "Would you like to enable STRICTER protection (requires PRs)? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "This will require:"
    echo "  • Pull requests before merging"
    echo "  • 0 approvals (since you're solo)"
    echo "  • Conversation resolution"
    echo ""
    read -p "Which repository? (1=emiliok, 2=vikunja, 3=both): " REPO_CHOICE
    
    # Stricter protection JSON
    read -r -d '' STRICT_JSON << 'EOF' || true
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 0
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_linear_history": false,
  "required_conversation_resolution": true
}
EOF

    case $REPO_CHOICE in
        1)
            echo ""
            echo "$STRICT_JSON" | gh api -X PUT -H "Accept: application/vnd.github+json" \
                "/repos/schoedel-learn/emiliokofficial-laravel/branches/main/protection" --input -
            echo -e "${GREEN}✅ Stricter protection enabled for emiliokofficial-laravel${NC}"
            ;;
        2)
            echo ""
            echo "$STRICT_JSON" | gh api -X PUT -H "Accept: application/vnd.github+json" \
                "/repos/${VOICE_OWNER}/vikunja-voice-automation/branches/main/protection" --input -
            echo -e "${GREEN}✅ Stricter protection enabled for vikunja-voice-automation${NC}"
            ;;
        3)
            echo ""
            echo "$STRICT_JSON" | gh api -X PUT -H "Accept: application/vnd.github+json" \
                "/repos/schoedel-learn/emiliokofficial-laravel/branches/main/protection" --input -
            echo "$STRICT_JSON" | gh api -X PUT -H "Accept: application/vnd.github+json" \
                "/repos/${VOICE_OWNER}/vikunja-voice-automation/branches/main/protection" --input -
            echo -e "${GREEN}✅ Stricter protection enabled for both repositories${NC}"
            ;;
    esac
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}🎉 Branch protection setup complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "What was configured:"
echo "  ✅ Force pushes blocked"
echo "  ✅ Branch deletions blocked"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "  ✅ Pull requests required"
    echo "  ✅ Conversation resolution required"
fi
echo ""
echo "Verify on GitHub:"
echo "  • emiliokofficial-laravel: https://github.com/schoedel-learn/emiliokofficial-laravel/settings/branches"
echo "  • vikunja-voice-automation: https://github.com/${VOICE_OWNER}/vikunja-voice-automation/settings/branches"
echo ""
echo "To modify settings later, run this script again or use GitHub web UI"
echo ""

