# 🌅 Resume Tomorrow - Complete Setup Guide

**Status**: Ready to complete Mailcow integration and activate n8n workflow

**Estimated Time**: 30-45 minutes to complete everything

---

## 🎯 Where We Left Off

### ✅ **Completed Today (HUGE Progress!)**

1. **Voice-to-Tasks Core System**
   - ✅ GPT-5 + Vikunja integration working (100% test accuracy!)
   - ✅ Open WebUI function installed and tested
   - ✅ Fixed critical Vikunja API bug (POST → PUT)
   - ✅ Created 4 tasks from rambling voice note successfully

2. **GitHub Repositories**
   - ✅ Created professional `vikunja-voice-automation` repository
   - ✅ All documentation complete (README, Contributing, Security, etc.)
   - ✅ Branch protection enabled on both repositories
   - ✅ Issue/PR templates ready

3. **n8n Workflow**
   - ✅ Designed complete automation workflow
   - ✅ **Optimized for Google Recorder** (.txt transcripts)
   - ✅ Removed Whisper API (saves money & time!)
   - ✅ Workflow uploaded to n8n server
   - ✅ Ready for credential configuration

4. **Infrastructure**
   - ✅ Vikunja running: https://tasks.opshub.host/
   - ✅ Open WebUI running: https://ai.opshub.host/
   - ✅ n8n running: https://n8n.opshub.app/
   - ✅ All secured with SSL

### ⏳ **To Complete Tomorrow**

1. **Mailcow Setup** (15-20 minutes)
2. **n8n Credential Configuration** (10 minutes)
3. **End-to-End Testing** (5-10 minutes)
4. **Optional: RunPod GPU Setup** (if time permits)

---

## 📋 Tomorrow's Step-by-Step Plan

### **Phase 1: Complete Mailcow Setup** ⏱️ 15-20 min

#### **Server Access**
```bash
ssh root@72.60.112.30
Password: o)Vw0rG@LQwonlDzFbQ8
```

#### **Mailcow Details**
- **URL**: https://srv.opshubmail.com/admin/
- **Domain**: srv.opshubmail.com
- **Status**: Installed, needs mailbox creation

#### **Steps to Complete:**

1. **Log into Mailcow Admin**
   - URL: https://srv.opshubmail.com/admin/
   - Username: `admin`
   - Password: You set this during setup (try default: `moohoo`)

2. **Create Tasks Mailbox**
   - Click **"Email"** → **"Mailboxes"** → **"Add mailbox"**
   - **Email**: `tasks@srv.opshubmail.com`
   - **Name**: Task Automation
   - **Password**: Choose strong password (save it!)
   - **Quota**: 1GB is fine
   - Click **"Add"**

3. **Verify Mail Settings**
   - **IMAP**: `srv.opshubmail.com` port `993` (SSL)
   - **SMTP**: `srv.opshubmail.com` port `587` (STARTTLS)

4. **Test Email Access** (Optional but recommended)
   - Try logging into webmail: https://srv.opshubmail.com/
   - Or test with any email client using the credentials

---

### **Phase 2: Configure n8n Workflow** ⏱️ 10 min

#### **Access n8n**
- URL: https://n8n.opshub.app/
- Login with your account (you created owner account today)

#### **Find the Workflow**
- Look for: **"Voice to Vikunja Tasks (Text Transcript)"**
- Open it

#### **Configure 3 Credentials:**

##### **1. IMAP Credential**
Click the "Email Trigger - Voice Notes" node:
- **Credential Name**: `tasks@srv.opshubmail.com IMAP`
- **User**: `tasks@srv.opshubmail.com`
- **Password**: [Password you set in Mailcow]
- **Host**: `srv.opshubmail.com`
- **Port**: `993`
- **SSL/TLS**: `ON` (enabled)
- Click **"Create"** or **"Save"**

##### **2. SMTP Credential**
Click the "Send Confirmation Email" node:
- **Credential Name**: `tasks@srv.opshubmail.com SMTP`
- **User**: `tasks@srv.opshubmail.com`
- **Password**: [Same password as IMAP]
- **Host**: `srv.opshubmail.com`
- **Port**: `587`
- **Security**: `STARTTLS` or `None` (Mailcow handles it)
- Click **"Create"** or **"Save"**

##### **3. OpenAI API Credential**
Click the "GPT-4o with Functions" node:
- **Credential Name**: `OpenAI API`
- **API Key**: `YOUR_OPENAI_API_KEY_HERE`
- Click **"Create"** or **"Save"**

#### **Activate Workflow**
1. Click **"Active"** toggle in top-right (turns green/blue)
2. Click **"Save"** button
3. Done! ✅

---

### **Phase 3: Test End-to-End** ⏱️ 5-10 min

#### **Test the Complete Workflow:**

1. **Record Test Voice Note in Google Recorder:**
   - Say something like:
     > "Okay, I need to test the voice to tasks workflow. First, remind me to finish the Mailcow documentation. Second, I should test the email integration. And third, celebrate that everything is working!"

2. **Share the Recording:**
   - Tap the recording in Google Recorder
   - Tap **"Share"** icon
   - Select **"Email"**
   - **To**: `tasks@srv.opshubmail.com`
   - **Subject**: "Test Voice Note"
   - **Send**

3. **Wait 1-2 Minutes** ⏱️
   - n8n checks email every minute
   - Processing takes ~30-45 seconds total

4. **Check Vikunja:**
   - Go to: https://tasks.opshub.host/
   - You should see 3 new tasks created!
   - Check they're in appropriate projects

5. **Check Confirmation Email:**
   - Check your inbox (email you sent from)
   - Should receive confirmation with task links

#### **If It Works:**
🎉 **SUCCESS!** Your voice-to-tasks automation is LIVE!

#### **If It Doesn't Work:**
Check n8n execution history:
- Click workflow name → **"Executions"** tab
- Click the failed execution
- Look for error messages
- Common issues:
  - Credentials not saved properly
  - Email server connectivity
  - API token issues

---

### **Phase 4: Optional - RunPod GPU** ⏱️ 20-30 min

**Only do this if:**
- Everything else is working
- You want local model support
- You have extra time

#### **Quick Setup:**
1. Sign up: https://runpod.io/
2. Deploy Ollama pod (RTX 3090)
3. Connect to Open WebUI
4. Pull models (llama3.2, mistral)

**Full Guide**: See `RUNPOD-QUICK-START.md`

---

## 🔑 Quick Reference - Credentials

### **Mailcow (To Be Created Tomorrow)**
- **Email**: tasks@srv.opshubmail.com
- **Password**: [You'll set this]
- **IMAP**: srv.opshubmail.com:993 (SSL)
- **SMTP**: srv.opshubmail.com:587 (STARTTLS)
- **Webmail**: https://srv.opshubmail.com/

### **Vikunja**
- **URL**: https://tasks.opshub.host/
- **API Token**: tk_40f55f71353b7ee59f9d04119ffab4fe5432df19

### **n8n**
- **URL**: https://n8n.opshub.app/
- **Server**: 82.180.173.134
- **SSH**: root@82.180.173.134
- **Password**: Sn4-tSUfAtlp

### **Open WebUI**
- **URL**: https://ai.opshub.host/
- **Server**: 45.90.220.106
- **SSH**: root@45.90.220.106
- **Password**: Holy-words0267-houses

### **OpenAI**
- **API Key**: `YOUR_OPENAI_API_KEY_HERE`
- **Models**: GPT-5, GPT-4o, GPT-4

---

## 📊 Success Metrics to Check

After testing, verify:

- [ ] Email received by Mailcow inbox
- [ ] n8n workflow executed successfully
- [ ] .txt transcript extracted correctly
- [ ] GPT-4o called Vikunja functions
- [ ] Tasks created in Vikunja
- [ ] Confirmation email received
- [ ] All tasks visible in Vikunja UI

**Target**: 100% success rate (like your GPT-5 test today!)

---

## 🐛 Common Issues & Solutions

### **Issue 1: Mailcow Admin Login Fails**
**Solution**: Reset admin password via CLI:
```bash
ssh root@72.60.112.30
cd /opt/mailcow-dockerized
docker-compose exec mysql-mailcow mysql -uroot -p$(grep DBROOT= mailcow.conf | cut -d= -f2) mailcow
# Then UPDATE admin SET password = 'new_hash' WHERE username = 'admin';
```

### **Issue 2: n8n Can't Connect to Mailcow**
**Solution**: 
- Verify firewall allows ports 993 and 587
- Check Mailcow is running: `docker ps | grep mailcow`
- Test with telnet: `telnet srv.opshubmail.com 993`

### **Issue 3: GPT-4o Doesn't Call Functions**
**Solution**:
- Verify OpenAI API key has credits
- Check workflow uses GPT-4o (not GPT-3.5)
- Ensure tool definitions are correct in workflow

### **Issue 4: Tasks Not Created in Vikunja**
**Solution**:
- Verify Vikunja API token is valid
- Check project IDs exist
- Ensure using PUT method (not POST)
- Check Vikunja API logs

---

## 📁 Important Files

All files are in: `/Users/schoedel/Projects/vikunja-voice-automation/`

### **Setup Scripts**
- `upload-n8n-workflow.sh` - Upload workflow to n8n (already done)
- `setup-branch-protection.sh` - GitHub protection (already done)
- `setup-github-repo.sh` - Git initialization (already done)

### **Documentation**
- `README.md` - Public-facing project overview
- `PROJECT_STATUS.md` - Current development status
- `START_HERE.md` - Quick start guide
- `RESUME_TOMORROW.md` - This file!
- `BRANCH_PROTECTION_SETUP.md` - Branch protection guide
- `GITHUB_SETUP_COMPLETE.md` - GitHub setup details

### **Workflow Files**
- `n8n/voice-to-vikunja-txt.json` - Updated workflow (Google Recorder)

---

## 🎯 Tomorrow's Timeline

| Time | Task | Duration |
|------|------|----------|
| **Start** | Log into Mailcow | 2 min |
| | Create tasks mailbox | 5 min |
| | Verify email settings | 3 min |
| | **Subtotal** | **~10 min** |
| | | |
| | Open n8n workflow | 2 min |
| | Configure IMAP credential | 3 min |
| | Configure SMTP credential | 3 min |
| | Configure OpenAI credential | 2 min |
| | Activate workflow | 1 min |
| | **Subtotal** | **~11 min** |
| | | |
| | Record test voice note | 2 min |
| | Send to Mailcow | 1 min |
| | Wait for processing | 2 min |
| | Verify tasks in Vikunja | 2 min |
| | Check confirmation email | 1 min |
| | **Subtotal** | **~8 min** |
| | | |
| **TOTAL** | **Complete Automation** | **~30 min** |

---

## 🎉 What You'll Have When Done

### **Working System:**
```
📱 Google Recorder (record voice note)
  ↓
📧 Email to tasks@srv.opshubmail.com
  ↓
⚙️ n8n automation workflow
  ├─→ Extract .txt transcript
  ├─→ GPT-4o task extraction
  └─→ Vikunja task creation
  ↓
✅ Tasks in Vikunja + Confirmation email
```

### **Cost per Voice Note:**
- Google Recorder transcription: **FREE**
- GPT-4o API call: **~$0.01**
- Email processing: **FREE** (self-hosted)
- **Total: ~$0.01 per voice note**

### **Processing Time:**
- Email delivery: ~5 seconds
- n8n processing: ~30 seconds
- **Total: ~35 seconds** from send to tasks created

---

## 💡 Pro Tips

1. **Save Mailcow Password Securely**
   - Add to password manager
   - You'll use it for n8n credentials

2. **Test with Simple Voice Note First**
   - 1-2 tasks only
   - Verify it works before complex ones

3. **Check n8n Executions Tab**
   - Shows detailed logs
   - Helpful for debugging

4. **Start Workflow Inactive**
   - Configure everything first
   - Then activate to avoid errors

---

## 📞 Need Help Tomorrow?

### **If Mailcow Issues:**
- Check: `/opt/mailcow-dockerized/` on server
- Logs: `docker-compose logs -f mailcow`
- Docs: https://docs.mailcow.email/

### **If n8n Issues:**
- Check execution logs in n8n UI
- Restart: `docker restart root-n8n-1`
- Server: root@82.180.173.134

### **If Vikunja Issues:**
- API docs: https://vikunja.io/docs/api-documentation/
- Check project IDs match
- Verify API token valid

---

## 🚀 You're So Close!

**Today's Wins:**
- ✅ Built complete AI task automation system
- ✅ Integrated GPT-5 with Vikunja (working!)
- ✅ Created professional GitHub repositories
- ✅ Optimized workflow for Google Recorder
- ✅ Removed expensive Whisper API

**Tomorrow's Goal:**
- 🎯 Complete Mailcow setup (15 min)
- 🎯 Configure n8n credentials (10 min)
- 🎯 Test end-to-end (5 min)
- 🎯 **GO LIVE!** 🎉

---

**Get some rest! Tomorrow you'll have a fully working voice-to-tasks automation system!** 🌟

**Good luck with school work!** 📚

---

*Last Updated: October 28, 2025*  
*Status: 95% Complete - Just needs Mailcow + n8n credentials*  
*Estimated Completion: 30 minutes*

