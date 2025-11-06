# ⚡ Quick Start Guide - Get Running in 20 Minutes

**Last Updated:** October 29, 2025  
**Status:** Workflow uploaded ✅ | Credentials needed ⏳

---

## 🎯 Goal
Get your voice-to-tasks automation working end-to-end in ~20 minutes.

---

## ✅ What's Already Done
- ✅ n8n workflow uploaded to server
- ✅ Vikunja running and tested
- ✅ Open WebUI with GPT-5 integration working
- ✅ All infrastructure in place

---

## 🚀 What You Need to Do (4 Steps)

### Step 1: Choose Email Provider (2 minutes)

**Quick Decision:**
- Want it working TODAY? → **Use Gmail** (follow Section A)
- Can wait for Mailcow? → **See EMAIL_SETUP_OPTIONS.md**

#### Option A: Gmail Setup (Recommended for Quick Start)

1. Go to Google Account Security: https://myaccount.google.com/security
2. Enable 2-Step Verification (if not on)
3. Go to "App Passwords" → Generate new password
4. Select: Mail / Other (custom name: "n8n Voice Tasks")
5. **Copy the 16-character password** (you'll need it!)

**Your Gmail IMAP/SMTP Settings:**
```
IMAP Host: imap.gmail.com
IMAP Port: 993
SMTP Host: smtp.gmail.com
SMTP Port: 587
Username: your.email@gmail.com
Password: [16-char app password]
```

---

### Step 2: Configure n8n Credentials (10 minutes)

#### 2a. Open n8n
```
URL: https://n8n.opshub.app/
```

#### 2b. Go to Credentials Section
1. Click your profile icon (top right)
2. Select "Credentials"
3. Click "Create New Credential"

#### 2c. Create IMAP Credential
1. Search for "IMAP"
2. Click "IMAP"
3. Fill in:
   - **Name:** `Gmail IMAP` (or your provider)
   - **User:** `your.email@gmail.com`
   - **Password:** [16-char app password]
   - **Host:** `imap.gmail.com`
   - **Port:** `993`
   - **SSL/TLS:** ✅ Enable
4. Click "Create"

#### 2d. Create SMTP Credential
1. Click "Create New Credential" again
2. Search for "SMTP"
3. Fill in:
   - **Name:** `Gmail SMTP` (or your provider)
   - **User:** `your.email@gmail.com`
   - **Password:** [same 16-char app password]
   - **Host:** `smtp.gmail.com`
   - **Port:** `587`
   - **Secure Connection:** Select "STARTTLS"
4. Click "Create"

#### 2e. Create OpenAI Credential
1. Click "Create New Credential" again
2. Search for "OpenAI"
3. Fill in:
   - **Name:** `OpenAI API`
   - **API Key:** `sk-proj-...` (your OpenAI key)
4. Click "Create"

---

### Step 3: Assign Credentials to Workflow (5 minutes)

#### 3a. Open the Workflow
1. In n8n, click "Workflows" (sidebar)
2. Find: **"Voice to Vikunja Tasks (Text Transcript)"**
3. Click to open it

#### 3b. Assign IMAP Credential
1. Click the **"Email Trigger - Voice Notes"** node (first node)
2. In the right panel, find "Credential to connect with"
3. Select the IMAP credential you created
4. Click outside to save

#### 3c. Assign SMTP Credential
1. Click the **"Send Confirmation Email"** node (last node)
2. In the right panel, find "Credential to connect with"
3. Select the SMTP credential you created
4. Click outside to save

#### 3d. Assign OpenAI Credential
1. Click the **"GPT-4o with Functions"** node (middle node)
2. In the right panel, find "Credential to connect with"
3. Select the OpenAI credential you created
4. Click outside to save

#### 3e. Update Email Address (if using Gmail)
1. Click the **"Send Confirmation Email"** node
2. Find the "From Email" field
3. Change from `tasks@opshub.host` to `your.email@gmail.com`
4. Click outside to save

#### 3f. Save and Activate
1. Click **"Save"** button (top right)
2. Toggle **"Active"** switch to ON (top right - turns blue/green)
3. Confirm the workflow is active

---

### Step 4: Test It! (3 minutes)

#### 4a. Record Voice Note
1. Open Google Recorder on your phone
2. Record a test message:
   > "I need to test the voice automation system. Also add a task to review the documentation. And finally remind me to celebrate getting this working!"

3. Stop recording

#### 4b. Share via Email
1. Tap the recording
2. Tap "Share" icon
3. Select "Email" or "Gmail"
4. **To:** `your.email@gmail.com` (if using Gmail for testing)
5. **Subject:** "Test Voice Note"
6. Tap "Send"

**Important:** Google Recorder will attach BOTH:
- The audio file (.m4a or .mp3)
- The transcript (.txt) ← This is what n8n uses!

#### 4c. Wait for Processing
- n8n checks email every 1 minute
- Processing takes ~30-45 seconds
- Total wait: ~1-2 minutes

#### 4d. Check Results

**In Vikunja:**
1. Go to: https://tasks.opshub.host/
2. You should see 3 new tasks:
   - "Test the voice automation system"
   - "Review the documentation"
   - "Celebrate getting this working"

**In Your Email:**
1. Check inbox for confirmation email
2. Should have subject: "✅ Tasks Created from Voice Note"
3. Contains links to all created tasks

#### 4e. If It Worked:
🎉 **CONGRATULATIONS!** Your voice-to-tasks automation is LIVE!

#### 4f. If It Didn't Work:
Check n8n execution logs:
1. In n8n workflow, click "Executions" tab (top)
2. Find the most recent execution
3. Click to see details
4. Look for error messages

**Common issues:**
- Credentials not saved properly → Re-enter and save
- Email not received → Check spam folder, verify IMAP settings
- No .txt attachment → Make sure using Google Recorder (not regular voice memos)
- GPT-4o errors → Verify OpenAI API key has credits and GPT-4o access

---

## 🎯 Success Checklist

After testing, verify:

- [ ] Email received by your inbox (check n8n executions)
- [ ] .txt transcript extracted (check execution logs)
- [ ] GPT-4o called successfully (check execution logs)
- [ ] 3 tasks created in Vikunja
- [ ] Tasks have correct titles
- [ ] Tasks assigned to appropriate projects
- [ ] Confirmation email received

---

## 📊 What You Just Built

```
Your Phone (Google Recorder)
  ↓ Records + Transcribes
Email with .txt transcript
  ↓ Gmail/IMAP
n8n Workflow
  ├─ Extracts .txt file
  ├─ Sends to GPT-4o
  ├─ GPT-4o extracts tasks
  ├─ Calls Vikunja API
  └─ Sends confirmation email
  ↓
Organized Tasks in Vikunja!
```

---

## 💰 Cost Per Voice Note

- Google Recorder transcription: **FREE** ✅
- GPT-4o API call (~1000 tokens): **~$0.01** 💰
- Email processing (self-hosted): **FREE** ✅
- n8n automation (self-hosted): **FREE** ✅

**Total: ~$0.01 per voice note** (about 1 penny!)

---

## 🎨 Tips for Best Results

### Recording Tips:
- Speak clearly but naturally
- Mention project names if you want specific assignments
- Use transition phrases: "Also...", "And...", "Finally..."
- One voice note can contain multiple tasks

### Example Voice Notes:

**Good:**
> "I need to schedule a dentist appointment. Also remind me to call mom this weekend. And I should finish the budget report by Friday."

**Better:**
> "For my health project, schedule a dentist appointment. For personal tasks, remind me to call mom this weekend. And for work, finish the budget report by Friday."

---

## 🔧 Next Steps (Optional)

### Immediate Improvements:
1. **Test with complex voice notes** (5+ tasks)
2. **Try different project assignments** (mention project names)
3. **Test priority detection** (say "urgent" or "important")

### Future Enhancements:
1. **Switch to Mailcow** for production (see EMAIL_SETUP_OPTIONS.md)
2. **Add RunPod GPU** for local models (cost savings)
3. **Fix security issue** (move Vikunja token to credential)
4. **Create mobile shortcut** for one-tap recording + emailing

---

## 🐛 Troubleshooting

### "Email not being received"
- Check n8n executions tab
- Verify IMAP credentials
- Test IMAP connection: `telnet imap.gmail.com 993`
- Check Gmail spam folder

### "No .txt file found"
- Must use Google Recorder (not iOS Voice Memos)
- Google Recorder auto-generates .txt transcripts
- Alternative: Manually attach a .txt file with voice transcript

### "GPT-4o not extracting tasks"
- Verify OpenAI API key is valid
- Check you have credits in OpenAI account
- Ensure GPT-4o model is accessible (not all accounts have it)
- Try GPT-3.5-turbo as alternative (edit workflow)

### "Tasks created but in wrong projects"
- GPT-4o decides based on context
- Mention project names explicitly in voice notes
- You can manually move tasks in Vikunja later

### "Confirmation email not received"
- Check spam folder
- Verify SMTP credentials
- Check n8n execution logs for SMTP errors
- Test SMTP: `telnet smtp.gmail.com 587`

---

## 📞 Get Help

### Check These Resources:
1. **EMAIL_SETUP_OPTIONS.md** - Email provider details
2. **CURRENT_STATUS.md** - Project status and blockers
3. **n8n Executions Tab** - Detailed error logs
4. **OpenAI Dashboard** - API usage and errors

### If Still Stuck:
- Check n8n community forums
- Review Vikunja API docs
- Test each component individually

---

## 🎉 You Did It!

You now have an AI-powered voice-to-tasks automation system that:

✅ Works hands-free  
✅ Understands natural speech  
✅ Organizes tasks intelligently  
✅ Costs ~$0.01 per voice note  
✅ Is 100% self-hosted (except GPT-4o)  
✅ Is production-ready  

**Share your success!** Post on social media, write a blog post, or contribute back to the open-source community.

---

## 🚀 Future Ideas

- WhatsApp integration
- Slack bot version
- Meeting transcript → tasks
- Calendar integration for due dates
- Voice commands to query tasks
- Team collaboration features
- Mobile app with direct integration
- Offline mode with local AI models

---

**Ready? Let's go!** Start with Step 1 above. ⬆️

---

*Created: October 29, 2025*  
*Version: 1.0 - Post Workflow Upload*  
*Estimated Time: 20 minutes to completion*

