# 🚀 SFTPGo Approach - Self-Hosted File Drop

**Created:** October 29, 2025  
**Status:** RECOMMENDED - Best fit for self-hosted infrastructure!

---

## 🎯 The Solution

Use your self-hosted SFTPGo server as a file drop location for voice note transcripts, with n8n monitoring the folder for new files.

---

## ⭐ Why SFTPGo is PERFECT for This Project

### Aligns with Your Self-Hosted Philosophy
You're already running:
- ✅ Vikunja (self-hosted)
- ✅ n8n (self-hosted)
- ✅ Open WebUI (self-hosted)
- ✅ SFTPGo (self-hosted)

**This keeps everything under YOUR control!**

### Advantages Over All Other Options

| Feature | Email (Mailcow) | Google Drive | **SFTPGo** |
|---------|----------------|--------------|-----------|
| Self-Hosted | ✅ Yes | ❌ No | ✅ **Yes** |
| Privacy | ✅ Full | ❌ Limited | ✅ **Full** |
| Setup Complexity | 🔴 High | 🟡 Medium | 🟢 **Low** |
| n8n Integration | 🟡 Good | 🟢 Great | 🟢 **Great** |
| Cost | 💰 Server | 🆓 Free tier | 🆓 **Free** |
| Speed | 🐌 60+ sec | ⚡ 5-10 sec | ⚡ **<5 sec** |
| Maintenance | 🔴 Medium | 🟢 None | 🟢 **Minimal** |
| Email Blocker | ❌ Blocked | ✅ Works | ✅ **Works** |
| **Winner** | | | ✅ **SFTPGo** |

---

## 🏗️ Architecture

### Complete Flow:
```
📱 Google Recorder (Android Phone)
  ↓ Record voice note with transcript
  ↓ Share → SFTP app (Solid Explorer, FX File Explorer, etc.)
☁️  SFTPGo Server (your.server:2022)
  ↓ File drops into /voice-notes/ folder
⚙️  n8n SFTP Trigger (monitors folder)
  ↓ Detects new .txt file
  ↓ Reads file content
🤖 GPT-4o (extracts tasks)
  ↓ Function calling
📋 Vikunja (creates tasks)
  ↓ Tasks created
📧 Confirmation (email or notification)
```

### Data Path:
```
Phone → SFTP → n8n → GPT-4o → Vikunja → Done
```

**Total hops:** 4 (vs 5 for email)  
**External dependencies:** 1 (OpenAI) vs 2+ (email servers)  
**Your control:** 100% except GPT-4o

---

## 📋 Setup Requirements

### What You Already Have:
- ✅ SFTPGo server running
- ✅ n8n server running
- ✅ Network connectivity between them

### What You Need:
1. **SFTPGo user account** for file uploads (5 min)
2. **SFTP client on phone** (free app, 2 min)
3. **n8n SFTP credential** (5 min)
4. **Updated n8n workflow** (10 min)

**Total setup time: ~20 minutes**

---

## 🔧 Step-by-Step Implementation

### Step 1: Configure SFTPGo User (5 minutes)

#### 1a. Access SFTPGo Admin
```bash
# Your SFTPGo web interface
https://your-sftpgo-server:8080/admin
```

#### 1b. Create Voice Notes User
1. Log into SFTPGo admin panel
2. Go to **Users** → **Add User**
3. Configure:
   - **Username:** `voicenotes`
   - **Password:** [choose strong password]
   - **Home Directory:** `/home/voicenotes`
   - **Permissions:** Upload, List, Download
   - **Max Sessions:** 5
   - **Upload Bandwidth:** Unlimited (or set limit)
   - **Quota:** 1GB (more than enough for text files)

4. Create directory structure:
```bash
# On SFTPGo server:
mkdir -p /home/voicenotes/inbox
mkdir -p /home/voicenotes/processed
chown -R sftpgo:sftpgo /home/voicenotes
chmod 755 /home/voicenotes
```

#### 1c. Test SFTP Access
```bash
# From your computer:
sftp -P 2022 voicenotes@your-sftpgo-server

# If successful, you'll see:
sftp> ls
inbox/
processed/

sftp> exit
```

---

### Step 2: Install SFTP Client on Phone (2 minutes)

#### Recommended Android Apps:

**Option A: Solid Explorer** (Recommended)
- Play Store: Search "Solid Explorer"
- Free trial, then ~$3 one-time
- Excellent SFTP support
- Can add SFTP as share target

**Option B: FX File Explorer** (Free)
- Play Store: Search "FX File Explorer"
- Completely free
- Good SFTP support
- Share integration

**Option C: Total Commander** (Free)
- Play Store: Search "Total Commander"
- Free with plugins
- SFTP plugin available
- Classic file manager

#### Configure SFTP Connection:

In your chosen app:
1. Add new SFTP connection
2. Configure:
   - **Host:** `your-sftpgo-server`
   - **Port:** `2022` (or your SFTPGo port)
   - **Username:** `voicenotes`
   - **Password:** [password from Step 1]
   - **Start Directory:** `/inbox`
3. Save connection as "Voice Notes"
4. Test connection

---

### Step 3: Configure n8n SFTP Credential (5 minutes)

#### 3a. Create SFTP Credential in n8n
1. Go to n8n: https://n8n.opshub.app/
2. Click **Credentials** → **Create New**
3. Search for "SFTP"
4. Select **SFTP**
5. Configure:
   - **Name:** `SFTPGo Voice Notes`
   - **Host:** `your-sftpgo-server` (IP or hostname)
   - **Port:** `2022` (or your SFTPGo port)
   - **Username:** `voicenotes`
   - **Password:** [password from Step 1]
6. Click **Create**

#### 3b. Test Connection
1. In n8n, create test workflow
2. Add **SFTP** node
3. Operation: **List**
4. Path: `/inbox`
5. Assign credential
6. Execute node
7. Should see empty directory listing (success!)

---

### Step 4: Update n8n Workflow (10 minutes)

#### Option A: Polling Trigger (Simpler)

Replace the Email Trigger node with SFTP polling:

```json
{
  "name": "SFTP Trigger - Voice Notes",
  "type": "n8n-nodes-base.sftpTrigger",
  "typeVersion": 1,
  "position": [250, 300],
  "parameters": {
    "path": "/inbox",
    "pollTimes": {
      "item": [
        {
          "mode": "everyMinute"
        }
      ]
    },
    "options": {
      "fileExtensions": "txt"
    }
  },
  "credentials": {
    "sftp": {
      "id": "1",
      "name": "SFTPGo Voice Notes"
    }
  }
}
```

#### Option B: Webhook Trigger (Advanced, Faster)

Configure SFTPGo to call n8n webhook when file uploaded:

1. In SFTPGo: **Integrations** → **Webhooks**
2. Add webhook URL: `https://n8n.opshub.app/webhook/voice-notes`
3. Trigger: File upload
4. In n8n: Use **Webhook** trigger node

---

### Step 5: Update Workflow Nodes

#### 5a. Read File Node
After SFTP trigger, add node to read file:

```json
{
  "name": "Read Transcript Content",
  "type": "n8n-nodes-base.sftp",
  "parameters": {
    "operation": "download",
    "path": "={{$json.path}}",
    "options": {
      "encoding": "utf8"
    }
  },
  "credentials": {
    "sftp": {
      "id": "1",
      "name": "SFTPGo Voice Notes"
    }
  }
}
```

#### 5b. Move Processed File (Optional)
After successful processing, move file to processed folder:

```json
{
  "name": "Archive Processed File",
  "type": "n8n-nodes-base.sftp",
  "parameters": {
    "operation": "rename",
    "oldPath": "={{$json.path}}",
    "newPath": "=/processed/{{$json.filename}}"
  },
  "credentials": {
    "sftp": {
      "id": "1",
      "name": "SFTPGo Voice Notes"
    }
  }
}
```

#### 5c. Connect to Existing Workflow
The rest stays the same:
- Extract transcript text
- Send to GPT-4o
- Create tasks in Vikunja
- Send confirmation

---

## 📱 Mobile Usage Workflow

### One-Time Setup:
1. Install SFTP app (Solid Explorer recommended)
2. Add SFTPGo connection
3. Test upload once

### Daily Usage (Auto-backup version):
If using Tasker or automation:
```
1. Record voice note in Google Recorder
2. (Auto-upload via Tasker script)
3. Done! Tasks appear in Vikunja
```

### Daily Usage (Manual version):
```
1. Record voice note in Google Recorder
2. Tap "Share"
3. Select "Solid Explorer" (or your SFTP app)
4. Navigate to SFTP → inbox
5. Upload
6. Wait ~30 seconds
7. Tasks appear in Vikunja!
```

**Manual steps: 5** (same as email)  
**Wait time: ~30 seconds** (faster than email)

---

## 🎯 Complete Workflow JSON Concept

### New SFTP-Based Workflow Structure:

```json
{
  "nodes": [
    {
      "name": "SFTP Trigger - Voice Notes",
      "type": "n8n-nodes-base.sftpTrigger",
      "parameters": {
        "path": "/inbox",
        "pollTimes": {"item": [{"mode": "everyMinute"}]},
        "options": {"fileExtensions": "txt"}
      }
    },
    {
      "name": "Read Transcript",
      "type": "n8n-nodes-base.sftp",
      "parameters": {
        "operation": "download",
        "path": "={{$json.path}}"
      }
    },
    {
      "name": "Extract Text Content",
      "type": "n8n-nodes-base.code",
      "parameters": {
        "functionCode": "return {json: {transcript: $input.item.binary.data.toString('utf-8')}}"
      }
    },
    // ... rest of existing workflow (GPT-4o, Vikunja, etc.)
    {
      "name": "Move to Processed",
      "type": "n8n-nodes-base.sftp",
      "parameters": {
        "operation": "rename",
        "oldPath": "={{$json.originalPath}}",
        "newPath": "=/processed/{{$json.filename}}"
      }
    }
  ]
}
```

---

## 💪 Advanced Features

### Auto-Upload with Tasker (Android)

Create Tasker automation:

```
Profile: New Google Recorder File
Context: File Modified in /storage/emulated/0/Recorder/*

Task: Upload to SFTP
1. Wait 5 seconds (ensure recording complete)
2. Run Shell:
   scp -P 2022 %RFILE voicenotes@your-server:/inbox/
3. Notify: "Voice note uploaded"
```

### SFTPGo Event Actions

Configure SFTPGo to:
1. Call n8n webhook on upload (instant trigger)
2. Auto-archive old files (cleanup)
3. Send notifications (optional)
4. Validate file types (security)

### File Naming Pattern

Use Google Recorder's automatic naming:
```
Recording_2025-10-29_14-30-45.txt
Recording_2025-10-29_15-15-22.txt
```

n8n can extract timestamp and use as metadata.

---

## 🔐 Security Considerations

### Best Practices:

1. **Dedicated User**
   - ✅ Use `voicenotes` user (not root)
   - ✅ Limit permissions to upload/list only
   - ✅ Set quota limits

2. **Network Security**
   - ✅ Use SFTP (encrypted by default)
   - ✅ Consider VPN if on public network
   - ✅ Restrict IP access if possible

3. **File Validation**
   - ✅ Only accept .txt files
   - ✅ Limit file size (1MB max)
   - ✅ Scan for malicious content

4. **Access Control**
   - ✅ Strong password for SFTP user
   - ✅ SSH key authentication (even better)
   - ✅ Firewall rules

5. **Data Privacy**
   - ✅ All data stays on your servers
   - ✅ No third-party access
   - ✅ Full encryption in transit

---

## 🚀 Quick Start Guide

### Get Running in 20 Minutes:

**Minute 0-5: SFTPGo Setup**
1. Access SFTPGo admin
2. Create `voicenotes` user
3. Set password and permissions
4. Create directories

**Minute 5-7: Phone Setup**
1. Install Solid Explorer
2. Add SFTP connection
3. Test connection

**Minute 7-12: n8n Credential**
1. Open n8n
2. Create SFTP credential
3. Test connection

**Minute 12-22: Update Workflow**
1. Open existing workflow
2. Replace Email Trigger with SFTP Trigger
3. Add Read File node
4. Connect to existing GPT-4o node
5. Save and activate

**Minute 22-25: Test**
1. Record test voice note
2. Upload via SFTP app
3. Wait 30 seconds
4. Check Vikunja for tasks

**Done! 🎉**

---

## 📊 Performance Comparison

### Processing Time Breakdown:

**Email Approach:**
```
Recording      : 30 sec
Email send     : 5 sec
IMAP polling   : 0-60 sec (average 30)
Email parsing  : 5 sec
GPT-4o         : 15 sec
Vikunja        : 5 sec
TOTAL         : 90 seconds average
```

**SFTPGo Approach:**
```
Recording      : 30 sec
SFTP upload    : 2 sec
n8n polling    : 0-60 sec (average 30)
File read      : 1 sec
GPT-4o         : 15 sec
Vikunja        : 5 sec
TOTAL         : 83 seconds average
```

**SFTPGo + Webhook:**
```
Recording      : 30 sec
SFTP upload    : 2 sec
Webhook        : <1 sec (instant)
File read      : 1 sec
GPT-4o         : 15 sec
Vikunja        : 5 sec
TOTAL         : 53 seconds (40% faster!)
```

---

## 💰 Cost Analysis

### Infrastructure Costs:

**Email (Mailcow):**
- Server: $5-10/month
- Storage: Included
- Maintenance: 1-2 hours/month
- **Total: $5-10/month + time**

**Google Drive:**
- Service: FREE (15GB)
- No maintenance
- **Total: $0/month**

**SFTPGo:**
- Server: Already running (shared with other services)
- Storage: Minimal (~1MB for 1000 transcripts)
- Maintenance: Minutes/month
- **Total: $0/month (marginal cost)**

**Winner: SFTPGo** (leverages existing infrastructure)

---

## 🎯 Comparison to Other Approaches

### vs Email:
- ✅ Simpler (1 credential vs 3)
- ✅ Faster (no email delays)
- ✅ More reliable (no email server issues)
- ✅ Same privacy level
- ✅ Less maintenance

### vs Google Drive:
- ✅ More private (no Google access)
- ✅ Fully self-hosted
- ✅ No external dependencies
- ✅ Same or better performance
- 🟡 Requires phone SFTP app (one extra app)

### vs Cloud Storage (Dropbox, etc.):
- ✅ Free (no cloud storage fees)
- ✅ More private
- ✅ Faster (local network)
- ✅ Full control

---

## 🐛 Troubleshooting

### "Can't connect to SFTP from phone"
**Check:**
- SFTPGo is running: `systemctl status sftpgo`
- Port is open: `netstat -tuln | grep 2022`
- Firewall allows connection
- Using correct IP/hostname
- Username/password correct

### "n8n not detecting files"
**Check:**
- SFTP credential is correct
- Path `/inbox` is correct
- Workflow is active
- File extension filter is set to `txt`
- Execute workflow manually to test

### "File upload fails"
**Check:**
- User has upload permissions
- Quota not exceeded
- Disk space available
- File size within limits
- Network connectivity

### "Processing doesn't start"
**Check:**
- n8n polling interval (may take up to 60 sec)
- Workflow execution logs
- File is actually .txt format
- File has content (not empty)

---

## 📱 Phone App Recommendations

### Best Overall: Solid Explorer
- **Pros:** Beautiful UI, excellent SFTP support, share integration
- **Cons:** $3 after trial
- **Rating:** ⭐⭐⭐⭐⭐

### Best Free: FX File Explorer
- **Pros:** Free, good features, reliable SFTP
- **Cons:** Ads, slightly less polished
- **Rating:** ⭐⭐⭐⭐

### Most Powerful: Total Commander
- **Pros:** Feature-rich, plugin system, free
- **Cons:** Steeper learning curve
- **Rating:** ⭐⭐⭐⭐

### Automation-Friendly: Tasker + SSH Plugin
- **Pros:** Fully automated uploads
- **Cons:** Complex setup, requires Tasker purchase
- **Rating:** ⭐⭐⭐⭐⭐ (for power users)

---

## 🎉 Why This Is The Best Solution

### Perfect for Your Setup:
1. ✅ **Self-hosted** (matches your philosophy)
2. ✅ **Private** (no third parties)
3. ✅ **Fast** (local network speeds)
4. ✅ **Simple** (1 credential, few nodes)
5. ✅ **Reliable** (proven SFTP protocol)
6. ✅ **Free** (uses existing infrastructure)
7. ✅ **Secure** (encrypted, controlled)
8. ✅ **Flexible** (can automate or manual)

### Solves All Problems:
- ❌ Email blocker → ✅ Solved
- ❌ Complex setup → ✅ Simple
- ❌ External dependencies → ✅ Self-hosted
- ❌ Privacy concerns → ✅ Full control
- ❌ High costs → ✅ Free

---

## 🚀 Next Steps

### Ready to Implement?

1. **Create SFTP user in SFTPGo** (5 min)
2. **Install SFTP app on phone** (2 min)
3. **Configure n8n SFTP credential** (5 min)
4. **Update n8n workflow** (10 min)
5. **Test with voice note** (2 min)
6. **Celebrate!** 🎉

**Total time: 25 minutes to working system**

---

## 💡 Pro Tips

### For Best Experience:

1. **Use Webhook Trigger**
   - Configure SFTPGo to call n8n webhook
   - Instant processing (no polling delay)
   - More responsive

2. **Set Up Tasker Automation**
   - Auto-upload on recording
   - Zero manual steps
   - Seamless experience

3. **Enable SFTPGo Logging**
   - Monitor uploads
   - Debug issues
   - Track usage

4. **Create Archive Strategy**
   - Move processed files
   - Keep inbox clean
   - Prevent re-processing

5. **Use SSH Keys**
   - More secure than passwords
   - Can disable password auth
   - Better automation support

---

## 🎯 Conclusion

**SFTPGo is THE solution for your self-hosted setup!**

It combines:
- ✅ Best privacy (fully self-hosted)
- ✅ Best simplicity (1 credential)
- ✅ Best performance (local network)
- ✅ Best cost (free, uses existing server)
- ✅ Best alignment with your infrastructure

**Recommendation: Use SFTPGo approach!**

---

## 📞 Ready to Build This?

I can help you:
1. Create the updated workflow JSON
2. Write the SFTPGo user configuration
3. Create phone app setup guide
4. Test the complete flow
5. Set up automation (Tasker)

Just say the word! 🚀

---

*Created: October 29, 2025*  
*Purpose: Self-hosted file drop solution*  
*Status: RECOMMENDED - Best fit for this project!*


