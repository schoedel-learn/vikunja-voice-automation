#!/bin/bash

# Upload and Import Updated n8n Workflow (Google Recorder .txt version)

echo "📦 Uploading Updated n8n Workflow"
echo "================================="
echo ""

# Configuration
N8N_SERVER="82.180.173.134"
N8N_PASSWORD="Sn4-tSUfAtlp"
WORKFLOW_FILE="n8n/voice-to-vikunja-txt.json"

# Check if workflow file exists
if [ ! -f "$WORKFLOW_FILE" ]; then
    echo "❌ Error: $WORKFLOW_FILE not found"
    exit 1
fi

echo "✅ Workflow file found"
echo ""

# Upload workflow to server
echo "📤 Uploading workflow to n8n server..."
sshpass -p "$N8N_PASSWORD" scp -o StrictHostKeyChecking=no \
    "$WORKFLOW_FILE" \
    root@${N8N_SERVER}:/tmp/voice-to-vikunja-txt.json

if [ $? -eq 0 ]; then
    echo "✅ Upload successful"
else
    echo "❌ Upload failed"
    exit 1
fi

echo ""
echo "📥 Importing workflow into n8n..."

# Import workflow
sshpass -p "$N8N_PASSWORD" ssh -o StrictHostKeyChecking=no root@${N8N_SERVER} << 'ENDSSH'
# Copy into container
docker cp /tmp/voice-to-vikunja-txt.json root-n8n-1:/tmp/

# Import workflow
docker exec root-n8n-1 n8n import:workflow --input=/tmp/voice-to-vikunja-txt.json

echo ""
echo "✅ Workflow imported!"
ENDSSH

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Workflow Upload Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Open n8n: https://n8n.opshub.app/"
echo ""
echo "2. Find the workflow: 'Voice to Vikunja Tasks (Text Transcript)'"
echo ""
echo "3. Configure 3 credentials:"
echo "   📧 IMAP: tasks@opshub.host"
echo "   📧 SMTP: tasks@opshub.host"
echo "   🤖 OpenAI API: Your API key"
echo ""
echo "4. Activate the workflow (toggle ON)"
echo ""
echo "5. Test with Google Recorder:"
echo "   - Record voice note"
echo "   - Share as recording (sends .txt)"
echo "   - Email to: tasks@opshub.host"
echo "   - Wait ~1 minute"
echo "   - Check Vikunja for tasks!"
echo ""
echo "🎊 No Whisper API needed - saves money & time!"
echo ""

