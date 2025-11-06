#!/bin/bash

# Upload and Import n8n Workflow (SFTPGo version)

echo "📦 Uploading n8n Workflow (SFTP Version)"
echo "=========================================="
echo ""

# Configuration
N8N_SERVER="82.180.173.134"
N8N_PASSWORD="Sn4-tSUfAtlp"
WORKFLOW_FILE="n8n/voice-to-vikunja-sftp.json"

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
    root@${N8N_SERVER}:/tmp/voice-to-vikunja-sftp.json

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
docker cp /tmp/voice-to-vikunja-sftp.json root-n8n-1:/tmp/

# Import workflow
docker exec root-n8n-1 n8n import:workflow --input=/tmp/voice-to-vikunja-sftp.json

echo ""
echo "✅ Workflow imported!"
ENDSSH

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 SFTP Workflow Upload Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. 🔐 Set up SFTPGo user:"
echo "   - Access your SFTPGo admin panel"
echo "   - Create user: 'voicenotes'"
echo "   - Set home dir: /home/voicenotes"
echo "   - Create folders: /inbox and /processed"
echo ""
echo "2. 📱 Install SFTP app on phone:"
echo "   - Recommended: Solid Explorer"
echo "   - Alternative: FX File Explorer or Total Commander"
echo "   - Configure SFTP connection to your server"
echo ""
echo "3. ⚙️  Configure n8n credentials:"
echo "   - Open n8n: https://n8n.opshub.app/"
echo "   - Create SFTP credential"
echo "   - Create OpenAI credential"
echo ""
echo "4. 🔄 Find and configure the workflow:"
echo "   - Workflow name: 'Voice to Vikunja Tasks (SFTP)'"
echo "   - Assign SFTP credential to:"
echo "     • SFTP Trigger node"
echo "     • Read Transcript File node"
echo "     • Move to Processed Folder node"
echo "   - Assign OpenAI credential to GPT-4o node"
echo "   - Update confirmation email address (optional)"
echo ""
echo "5. ✅ Activate the workflow:"
echo "   - Toggle 'Active' switch to ON"
echo "   - Click 'Save'"
echo ""
echo "6. 🧪 Test with voice note:"
echo "   - Record voice note in Google Recorder"
echo "   - Share → SFTP app"
echo "   - Upload to /inbox folder"
echo "   - Wait ~30-60 seconds"
echo "   - Check Vikunja for tasks!"
echo ""
echo "🎊 Benefits of SFTP approach:"
echo "   ✅ Fully self-hosted (no email server needed!)"
echo "   ✅ Simpler setup (only 1 credential)"
echo "   ✅ Better privacy (all data on your servers)"
echo "   ✅ Faster processing (local network)"
echo "   ✅ Lower cost (uses existing infrastructure)"
echo ""
echo "📖 For detailed guide, see: SFTPGO_APPROACH.md"
echo ""


