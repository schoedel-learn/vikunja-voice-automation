# 📱 Phone Share Menu Integration - SFTP Upload

**Goal:** Add SFTP upload as a share option in Google Recorder, just like Gmail/Telegram

**Last Updated:** October 29, 2025

---

## 🎯 What You Want

When you tap "Share" in Google Recorder, you want to see:
```
Share via:
├─ Gmail ✓
├─ Telegram ✓
├─ SFTP Upload ← ADD THIS!
└─ ...
```

**Good news:** This is totally possible on Android!

---

## 🚀 Solution Options (Best to Advanced)

### Option 1: Solid Explorer Share Target ⭐ EASIEST

**Setup Time:** 2 minutes  
**Cost:** ~$3 (one-time)  
**Automation:** Semi-automatic (2 taps)

#### How It Works:
Solid Explorer can register as a share target, so it appears in your share menu.

#### Setup:
1. **Install Solid Explorer** from Play Store
2. **Configure SFTP bookmark:**
   - Open Solid Explorer
   - Add new bookmark (tap ≡ → Storage)
   - Select "Network" → "SFTP"
   - Configure:
     ```
     Host: your-sftpgo-server.com
     Port: 2022
     Username: voicenotes
     Password: [your password]
     Start path: /inbox
     ```
   - Save as "Voice Notes SFTP"

3. **Enable in Share Menu:**
   - In Solid Explorer settings
   - Look for "Share target" or "Accept shared files"
   - Enable it
   - Select the SFTP bookmark as default destination

4. **Test:**
   - Record in Google Recorder
   - Tap Share
   - Select "Solid Explorer"
   - Confirm upload to SFTP
   - Done!

#### User Experience:
```
1. Record voice note
2. Tap "Share"
3. Tap "Solid Explorer"
4. (Auto-uploads to /inbox)
5. Done! (2 taps after recording)
```

---

### Option 2: Tasker + AutoShare 🤖 MOST POWERFUL

**Setup Time:** 15-20 minutes  
**Cost:** ~$6 (Tasker $3.49 + AutoShare $2.49)  
**Automation:** Fully automatic (0 taps after setup!)

#### How It Works:
Tasker creates a custom share target that appears in your share menu and automatically uploads files to SFTP.

#### Setup:

##### Step 1: Install Apps
- **Tasker** ($3.49) - Automation platform
- **AutoShare** ($2.49) - Adds share menu integration
- **Termux** (Free) - Provides SSH/SFTP commands

##### Step 2: Configure Termux for SFTP
```bash
# In Termux:
pkg install openssh
```

##### Step 3: Create Tasker Profile

**Profile: AutoShare Event**
```
Event: AutoShare → Text Shared
Configure:
- Command Filter: Upload to Voice Notes
- Content Type: text/*, */*
```

**Task: Upload to SFTP**
```
Action 1: Variable Set
  - Name: %filename
  - To: %asfile (filename from AutoShare)

Action 2: Variable Set
  - Name: %content
  - To: %astext (text content from AutoShare)

Action 3: Run Shell
  - Command:
    echo "%content" > /storage/emulated/0/Download/%filename
    sshpass -p 'YOUR_PASSWORD' scp -P 2022 \
      /storage/emulated/0/Download/%filename \
      voicenotes@your-server:/inbox/
    rm /storage/emulated/0/Download/%filename
  - Use Root: No
  - Store Output: %output

Action 4: Flash
  - Text: Uploaded to SFTP!
  - If: %err !Set
  
Action 5: Flash (Error)
  - Text: Upload failed: %output
  - If: %err Set
```

##### Step 4: Configure AutoShare
1. Open AutoShare app
2. Go to "Manage Commands"
3. Add new command: "Upload to Voice Notes"
4. Set icon (optional)
5. Enable "Show in share menu"

#### User Experience:
```
1. Record voice note
2. Tap "Share"
3. Tap "Upload to Voice Notes"
4. (Auto-uploads in background)
5. See "Uploaded to SFTP!" notification
6. Done! (Just 2 taps!)
```

---

### Option 3: HTTP Shortcuts App 🌐 FREE ALTERNATIVE

**Setup Time:** 10 minutes  
**Cost:** FREE  
**Automation:** Semi-automatic (2 taps)

#### How It Works:
HTTP Shortcuts app can accept shared files and upload them via SFTP (using SSH/SCP commands).

#### Setup:

##### Step 1: Install Apps
- **HTTP Shortcuts** (Free) from Play Store
- **Termux** (Free) - For SSH support

##### Step 2: Configure Termux
```bash
# In Termux:
pkg install openssh

# Test SFTP connection:
scp -P 2022 testfile.txt voicenotes@your-server:/inbox/
```

##### Step 3: Create Shortcut in HTTP Shortcuts

1. Open HTTP Shortcuts
2. Create new shortcut
3. Configure:
   - **Name:** "Upload to Voice Notes"
   - **Method:** Run Script
   - **Script:**
     ```bash
     #!/system/bin/sh
     
     # Get shared file path
     FILE_PATH="$file_uris"
     
     # Upload to SFTP
     sshpass -p 'YOUR_PASSWORD' scp -P 2022 \
       "$FILE_PATH" \
       voicenotes@your-server:/inbox/
     
     echo "Uploaded successfully!"
     ```
4. Enable "Accept file shares"
5. Save

##### Step 4: Add to Share Menu
The shortcut will automatically appear in share menu once configured.

#### User Experience:
```
1. Record voice note
2. Tap "Share"
3. Tap "Upload to Voice Notes"
4. Wait for confirmation
5. Done!
```

---

### Option 4: FX File Explorer Share Target 📂 FREE & SIMPLE

**Setup Time:** 5 minutes  
**Cost:** FREE  
**Automation:** Semi-automatic (3 taps)

#### How It Works:
FX File Explorer has built-in share target support for cloud storage.

#### Setup:

1. **Install FX File Explorer** (Free) from Play Store

2. **Add SFTP Connection:**
   - Open FX File Explorer
   - Tap "Network" in sidebar
   - Tap "+" → "SFTP/FTPS/FTP"
   - Configure:
     ```
     Protocol: SFTP
     Host: your-server.com
     Port: 2022
     Username: voicenotes
     Password: [your password]
     Initial path: /inbox
     ```
   - Save as "Voice Notes"

3. **Pin to Main Screen:**
   - Long-press on "Voice Notes" connection
   - Select "Pin to main screen"

4. **Configure Share Target:**
   - FX Settings → Network
   - Enable "Accept shared files"
   - Set default to "Voice Notes" SFTP

#### User Experience:
```
1. Record voice note
2. Tap "Share"
3. Tap "FX File Explorer"
4. Confirm location (if prompted)
5. Done!
```

---

### Option 5: Android Shortcut with Intent 🔧 ADVANCED

**Setup Time:** 20 minutes  
**Cost:** FREE  
**Automation:** Requires scripting  
**Skill Level:** Advanced

#### How It Works:
Create a custom Android shortcut that accepts file intents and uploads via SFTP.

#### Setup:

This requires creating a custom Android app or using Tasker's shortcut feature.

**Using Tasker's Shortcut Feature:**

1. Create Tasker task (see Option 2)
2. Long-press home screen
3. Add Widget → Tasker → Task Shortcut
4. Select your upload task
5. Name it "Upload to Voice Notes"

**Now accessible from:**
- Home screen widget
- Share menu (if configured)
- Quick settings tile

---

## 🎯 Recommended Approach

### For Best User Experience:

**Tier 1: Maximum Automation** 🏆
- Use **Tasker + AutoShare**
- Cost: ~$6 (one-time)
- Result: 2 taps, automatic upload, notifications
- **Best for:** Daily heavy use

**Tier 2: Good Balance** ⭐
- Use **Solid Explorer**
- Cost: ~$3 (one-time)
- Result: 2 taps, guided upload
- **Best for:** Regular use, simpler setup

**Tier 3: Free Option** 💰
- Use **FX File Explorer** or **HTTP Shortcuts**
- Cost: FREE
- Result: 2-3 taps, manual confirmation
- **Best for:** Occasional use, testing

---

## 📱 Setup Comparison

| Solution | Cost | Setup Time | Taps | Auto | Notifications |
|----------|------|------------|------|------|---------------|
| **Tasker + AutoShare** | $6 | 20 min | 2 | ✅ Yes | ✅ Yes |
| **Solid Explorer** | $3 | 2 min | 2 | 🟡 Semi | ❌ No |
| **HTTP Shortcuts** | FREE | 10 min | 2 | 🟡 Semi | ✅ Yes |
| **FX File Explorer** | FREE | 5 min | 3 | ❌ No | ❌ No |

---

## 🚀 Quick Start: Solid Explorer (Recommended)

### Get Set Up in 5 Minutes:

#### Step 1: Install (1 min)
```
1. Open Play Store
2. Search "Solid Explorer"
3. Install
4. Start 14-day trial (or buy for $3)
```

#### Step 2: Add SFTP Bookmark (2 min)
```
1. Open Solid Explorer
2. Tap ≡ (menu) → Storage
3. Tap "+" → Network → SFTP
4. Fill in:
   Name: Voice Notes
   Host: [your SFTPGo server]
   Port: 2022
   Username: voicenotes
   Password: [your password]
   Start path: /inbox
5. Save
6. Test connection
```

#### Step 3: Configure Share Target (1 min)
```
1. Tap ≡ → Settings
2. Find "Other" section
3. Enable "Accept shared files"
4. Set default: "Voice Notes"
5. Done!
```

#### Step 4: Test (1 min)
```
1. Record test in Google Recorder
2. Tap "Share"
3. Select "Solid Explorer"
4. Confirm upload
5. Check n8n executions
6. Check Vikunja for tasks
```

**Done! Now "Solid Explorer" appears in your share menu! 🎉**

---

## 🎨 Advanced: Tasker Full Automation

### For Maximum Automation:

This creates a completely hands-free experience after recording.

#### The Ultimate Setup:

**Profile 1: Detect New Recording**
```
Context: File Modified
  - File: /storage/emulated/0/Recorder/*
  - Any file in Recorder directory
```

**Task: Auto-Upload New Recording**
```
Action 1: Wait
  - 5 seconds (ensure recording complete)

Action 2: List Files
  - Dir: /storage/emulated/0/Recorder/
  - Match: *.txt
  - Variable: %files
  - Sort: Modified (newest first)

Action 3: Variable Set
  - Name: %newest_file
  - To: %files1 (first file in list)

Action 4: Run Shell
  - Command:
    sshpass -p 'PASSWORD' scp -P 2022 \
      "%newest_file" \
      voicenotes@server:/inbox/
  
Action 5: Notify Sound
  - Title: Voice Note Uploaded
  - Text: Processing started
  - Sound: notification.mp3
```

**Result:**
```
1. Record voice note
2. Stop recording
3. (Everything else happens automatically!)
4. Get notification when uploaded
5. Tasks appear in Vikunja ~30 sec later
```

**Total user actions: ZERO (after initial recording)!**

---

## 💡 Pro Tips

### For Best Experience:

1. **Use Meaningful Names**
   - Name your SFTP connection clearly
   - "Voice Notes SFTP" is better than "Server1"

2. **Test Thoroughly**
   - Upload test file manually first
   - Verify it appears in /inbox
   - Check n8n detects it
   - Confirm tasks are created

3. **Add Notifications** (with Tasker)
   - Notify when upload starts
   - Notify when upload completes
   - Notify if upload fails

4. **Consider Battery Usage**
   - Tasker uses minimal battery
   - SFTP uploads are quick (<5 seconds)
   - No significant impact

5. **Backup Configuration**
   - Export Tasker tasks (Settings → Backup)
   - Save SFTP credentials securely
   - Document your setup

---

## 🔐 Security Considerations

### Keep Your Setup Secure:

1. **Strong Passwords**
   - Use strong password for SFTP user
   - Don't reuse passwords
   - Consider SSH key auth

2. **Limit Permissions**
   - SFTP user only needs upload to /inbox
   - No delete permissions needed
   - Read-only on /processed (optional)

3. **Network Security**
   - Use VPN if on public WiFi
   - Consider IP whitelist on SFTPGo
   - Enable 2FA if available

4. **Phone Security**
   - Lock screen enabled
   - App passwords/encryption
   - Remote wipe capability

5. **Data Privacy**
   - Transcripts contain personal info
   - Keep phone secure
   - Regular security updates

---

## 🐛 Troubleshooting

### Common Issues:

#### "Share option doesn't appear"
**Solution:**
- Restart the file manager app
- Clear Android share cache (Settings → Apps → Default Apps)
- Reinstall app
- Check app permissions

#### "Upload fails"
**Solution:**
- Test SFTP connection manually
- Check server is reachable
- Verify username/password
- Check network connectivity
- Look at app logs

#### "File not detected in n8n"
**Solution:**
- Verify file is .txt format
- Check file is in /inbox folder
- Confirm n8n workflow is active
- Check n8n polling interval
- Look at n8n execution logs

#### "Tasker not triggering"
**Solution:**
- Check profile is enabled
- Verify file path is correct
- Test profile manually
- Check Android battery optimization
- Review Tasker logs

---

## 📊 User Experience Comparison

### Daily Workflow:

**Without Share Integration:**
```
1. Record voice note
2. Open file manager
3. Navigate to Recorder folder
4. Find newest recording
5. Connect to SFTP
6. Navigate to /inbox
7. Upload file
8. Wait for confirmation
────────────────────────
Total: 8 steps, ~60 seconds
```

**With Share Integration (Solid Explorer):**
```
1. Record voice note
2. Tap "Share"
3. Tap "Solid Explorer"
────────────────────────
Total: 3 steps, ~15 seconds
```

**With Full Automation (Tasker):**
```
1. Record voice note
2. (Everything else automatic)
────────────────────────
Total: 1 step, ~5 seconds
```

**Improvement: 80-95% time savings! 🚀**

---

## 🎯 Recommended Setup Path

### Start Simple, Optimize Later:

#### Week 1: Basic Setup
1. Install Solid Explorer (free trial)
2. Configure SFTP connection
3. Test manual uploads
4. Use for 1 week

#### Week 2: Add Share Integration
1. Enable share target in Solid Explorer
2. Test from Google Recorder
3. Use for 1 week
4. Evaluate experience

#### Week 3: Consider Automation
1. If using daily, consider Tasker
2. Set up basic automation
3. Test thoroughly
4. Refine workflow

#### Week 4: Optimize
1. Add notifications
2. Fine-tune settings
3. Consider full automation
4. Enjoy seamless workflow!

---

## 🎉 The End Result

### After Setup, Your Workflow Is:

```
📱 Record in Google Recorder
  ↓ Tap "Share"
  ↓ Tap "Solid Explorer" (or "Upload to Voice Notes")
☁️  Auto-uploads to SFTP /inbox
  ↓ n8n detects new file
⚙️  Processing starts automatically
  ↓ GPT-4o extracts tasks
📋 Tasks appear in Vikunja
  ↓ Notification received (optional)
✅ Done!

Total user actions: 2 taps
Total time: ~15 seconds
Processing time: ~30-60 seconds
```

**From rambling voice note to organized tasks in under 90 seconds!**

---

## 📞 Next Steps

### Ready to Set This Up?

**Easiest path:**
1. Install Solid Explorer (free trial)
2. Follow "Quick Start" section above
3. Test with voice note
4. Enjoy!

**Ultimate automation:**
1. Buy Tasker + AutoShare (~$6)
2. Follow "Tasker Full Automation" section
3. Set up and forget
4. Just record and go!

---

## 💬 Need Help?

### Questions to Consider:

**Q: Which solution should I choose?**
- Daily use → Tasker (full automation)
- Regular use → Solid Explorer (good balance)
- Testing → FX File Explorer (free)

**Q: Is it worth paying for Tasker?**
- If you record >3 times/day → Yes!
- Saves ~30 seconds per recording
- 90 recordings = break even on time
- Plus: can automate other things

**Q: Can I use SSH keys instead of passwords?**
- Yes! Even more secure
- Solid Explorer supports SSH keys
- Tasker/Termux support SSH keys
- Recommended for production

---

*Created: October 29, 2025*  
*Purpose: Add SFTP upload to Android share menu*  
*Recommended: Start with Solid Explorer, upgrade to Tasker if heavy use*


