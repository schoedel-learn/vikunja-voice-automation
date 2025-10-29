#!/bin/bash

# Update GitHub Repository with New Workflow

echo "📦 Updating GitHub Repository"
echo "=============================="
echo ""

cd /Users/schoedel/Projects/vikunja-voice-automation

# Check git status
echo "🔍 Checking for changes..."
git status

echo ""
echo "📝 Staging new files..."

# Add new files
git add n8n/
git add upload-n8n-workflow.sh
git add RESUME_TOMORROW.md
git add update-github.sh

# Show what will be committed
echo ""
echo "📋 Files to commit:"
git status --short

echo ""
read -p "Commit these changes? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "💾 Creating commit..."
    
    git commit -m "feat: Optimize workflow for Google Recorder transcripts

- Added n8n workflow for .txt transcript processing
- Removed Whisper API dependency (saves costs)
- Faster processing (~30s vs ~60s)
- Added upload script for workflow deployment
- Added RESUME_TOMORROW guide for next session

Changes:
- New: n8n/voice-to-vikunja-txt.json
- New: upload-n8n-workflow.sh
- New: RESUME_TOMORROW.md
- New: update-github.sh

Benefits:
- No Whisper API costs (~\$0.01 savings per note)
- 50% faster processing
- Leverages Google Recorder's built-in transcription"

    echo ""
    echo "📤 Pushing to GitHub..."
    git push origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Repository updated successfully!"
        echo ""
        echo "🌐 View on GitHub:"
        echo "   https://github.com/schoedel-learn/vikunja-voice-automation"
        echo ""
    else
        echo ""
        echo "❌ Push failed. Check your connection and try again."
    fi
else
    echo ""
    echo "⏸️  Commit cancelled"
fi

