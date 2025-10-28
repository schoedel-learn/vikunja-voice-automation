# 🛡️ Branch Protection Setup Guide

You can set up branch protection **from the command line** using either GitHub CLI or curl with a Personal Access Token.

---

## **Option 1: Using the Automated Script** ⚡ (Easiest)

### **Step 1: Make script executable**
```bash
cd /Users/schoedel/Projects/vikunja-voice-automation
chmod +x setup-branch-protection.sh
```

### **Step 2: Run the script**
```bash
./setup-branch-protection.sh
```

The script will:
- Detect if you have GitHub CLI installed
- Guide you through authentication
- Configure protection for both repositories
- Give you the option for stricter rules

---

## **Option 2: Using GitHub CLI** 🔧 (Recommended)

### **Install GitHub CLI** (if not installed)

**macOS:**
```bash
brew install gh
```

**Linux:**
```bash
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

**Windows:**
```bash
winget install --id GitHub.cli
```

### **Authenticate with GitHub**
```bash
gh auth login
```

Follow the prompts:
1. Choose: **GitHub.com**
2. Choose: **HTTPS**
3. Choose: **Login with a web browser**
4. Copy the code and paste it in your browser

### **Set Up Branch Protection**

#### **For emiliokofficial-laravel:**
```bash
gh api \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  /repos/schoedel-learn/emiliokofficial-laravel/branches/main/protection \
  -f allow_force_pushes=false \
  -f allow_deletions=false \
  -F required_pull_request_reviews=null \
  -F required_status_checks=null \
  -F restrictions=null \
  -f enforce_admins=false
```

#### **For vikunja-voice-automation:**
```bash
# Replace YOUR-USERNAME with your actual GitHub username
gh api \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  /repos/YOUR-USERNAME/vikunja-voice-automation/branches/main/protection \
  -f allow_force_pushes=false \
  -f allow_deletions=false \
  -F required_pull_request_reviews=null \
  -F required_status_checks=null \
  -F restrictions=null \
  -f enforce_admins=false
```

### **Verify It Worked**
```bash
# Check emiliokofficial-laravel
gh api /repos/schoedel-learn/emiliokofficial-laravel/branches/main/protection

# Check vikunja-voice-automation (replace YOUR-USERNAME)
gh api /repos/YOUR-USERNAME/vikunja-voice-automation/branches/main/protection
```

You should see JSON output showing `"allow_force_pushes": false` and `"allow_deletions": false`.

---

## **Option 3: Using curl + Personal Access Token** 🔑

### **Step 1: Create Personal Access Token**

1. Go to: https://github.com/settings/tokens/new
2. **Note:** "Branch Protection Setup"
3. **Expiration:** Choose duration (recommend 90 days)
4. **Scopes:** Check **`repo`** (Full control of private repositories)
5. Click **"Generate token"**
6. **Copy the token** (you won't see it again!)

### **Step 2: Set Up Protection**

#### **For emiliokofficial-laravel:**
```bash
curl -X PUT \
  -H "Authorization: token YOUR_GITHUB_TOKEN_HERE" \
  -H "Accept: application/vnd.github+json" \
  -d '{
    "required_status_checks": null,
    "enforce_admins": false,
    "required_pull_request_reviews": null,
    "restrictions": null,
    "allow_force_pushes": false,
    "allow_deletions": false
  }' \
  https://api.github.com/repos/schoedel-learn/emiliokofficial-laravel/branches/main/protection
```

#### **For vikunja-voice-automation:**
```bash
# Replace YOUR_GITHUB_TOKEN_HERE and YOUR-USERNAME
curl -X PUT \
  -H "Authorization: token YOUR_GITHUB_TOKEN_HERE" \
  -H "Accept: application/vnd.github+json" \
  -d '{
    "required_status_checks": null,
    "enforce_admins": false,
    "required_pull_request_reviews": null,
    "restrictions": null,
    "allow_force_pushes": false,
    "allow_deletions": false
  }' \
  https://api.github.com/repos/YOUR-USERNAME/vikunja-voice-automation/branches/main/protection
```

---

## **Option 4: Stricter Protection** 🔒 (Requires PRs)

If you want to enforce pull requests even for yourself:

### **Using GitHub CLI:**
```bash
gh api \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  /repos/schoedel-learn/emiliokofficial-laravel/branches/main/protection \
  -f allow_force_pushes=false \
  -f allow_deletions=false \
  -f required_conversation_resolution=true \
  -F required_pull_request_reviews='{"required_approving_review_count":0}' \
  -F required_status_checks=null \
  -F restrictions=null \
  -f enforce_admins=false
```

This adds:
- ✅ Requires pull requests (but no approvals needed for solo work)
- ✅ Requires conversation resolution before merging

---

## **Troubleshooting**

### **Error: "Resource protected by organization SAML enforcement"**
- Your organization requires SSO
- Authorize your token: https://github.com/settings/tokens → Click token → Authorize

### **Error: "Not Found" or 404**
- Repository doesn't exist yet (need to push first)
- Check repository name spelling
- Check owner/username is correct

### **Error: "Requires authentication"**
- Token is invalid or expired
- Token doesn't have `repo` scope
- Re-authenticate with GitHub CLI

### **Error: "Must have admin rights"**
- You need admin permissions on the repository
- Check you're the owner or have admin access

---

## **What Gets Protected**

### **Basic Protection** (What we're setting up):
```
✅ Force pushes: BLOCKED
   - Can't do: git push --force
   - Can't do: git push --force-with-lease

✅ Branch deletion: BLOCKED
   - Can't delete main branch accidentally
   - Can't delete via git push :main

❌ Direct commits: ALLOWED
   - You can still push directly to main
   - Good for solo development
```

### **Strict Protection** (Optional):
```
✅ Everything from Basic, plus:

✅ Direct commits: BLOCKED
   - Must create PR even for your own changes
   - Enforces code review workflow

✅ Conversation resolution: REQUIRED
   - All comments must be resolved
   - Good for collaboration
```

---

## **Verify Protection is Active**

### **On GitHub Website:**
1. Go to your repository
2. Look at branch dropdown (top-left)
3. You should see a shield icon 🛡️ next to `main`

### **Via Command Line:**
```bash
# Check if protection is enabled
gh api /repos/schoedel-learn/emiliokofficial-laravel/branches/main --jq '.protected'

# Should return: true
```

---

## **Quick Commands Reference**

### **Check current protection:**
```bash
gh api /repos/OWNER/REPO/branches/main/protection
```

### **Remove protection** (if needed):
```bash
gh api -X DELETE /repos/OWNER/REPO/branches/main/protection
```

### **Update protection** (run PUT command again with new settings)

---

## **Recommended Settings by Project Type**

### **Solo Personal Project** (Your current situation):
```json
{
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_pull_request_reviews": null
}
```

### **Solo but Want Discipline:**
```json
{
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0
  }
}
```

### **Team Collaboration:**
```json
{
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true
  },
  "required_conversation_resolution": true
}
```

---

## **After Setup**

### **Test It Works:**

Try to force push (this should fail):
```bash
git push --force
# Should see: "protected branch hook declined"
```

Try to delete branch (this should fail):
```bash
git push origin :main
# Should see: "deletion of the current branch is prohibited"
```

### **If You Need to Bypass:**

1. **Temporary:** Disable protection in GitHub settings
2. **Permanent:** Give yourself bypass permissions in the protection rule
3. **Best Practice:** Don't bypass - there's usually a better way!

---

## **Next Steps**

After setting up branch protection:

1. ✅ Verify shield icon appears on GitHub
2. ✅ Test that force push is blocked
3. ✅ Update documentation if needed
4. ✅ Set up same protection for other branches (if any)

---

## **Resources**

- **GitHub Docs:** https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches
- **GitHub CLI Docs:** https://cli.github.com/manual/
- **GitHub API Docs:** https://docs.github.com/en/rest/branches/branch-protection

---

**Questions? Check the docs or ask in GitHub Discussions!**

