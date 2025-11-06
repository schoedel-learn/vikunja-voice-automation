# 📱 Quick Phone Setup - 5 Minutes

**Goal:** Add "SFTP Upload" to your share menu

---

## ⚡ Fastest Method: Solid Explorer

### Step 1: Install App (1 min)
```
Play Store → "Solid Explorer" → Install
(Free 14-day trial, then $2.99)
```

### Step 2: Add SFTP Connection (2 min)
```
1. Open Solid Explorer
2. Tap ≡ (menu, top-left)
3. Tap "Storage"
4. Tap "+" (bottom-right)
5. Select "SFTP"
6. Fill in:
   ┌─────────────────────────────────┐
   │ Name: Voice Notes               │
   │ Host: your-sftpgo-server.com    │
   │ Port: 2022                      │
   │ Username: voicenotes            │
   │ Password: ••••••••              │
   │ Initial path: /inbox            │
   └─────────────────────────────────┘
7. Tap "Connect" to test
8. Tap "✓" to save
```

### Step 3: Enable Share Target (1 min)
```
1. In Solid Explorer, tap ≡ → Settings
2. Scroll to "Other" section
3. Enable "Accept shared files"
4. Select "Voice Notes" as default
5. Done!
```

### Step 4: Test! (1 min)
```
1. Open Google Recorder
2. Record test message
3. Tap "Share" button
4. Look for "Solid Explorer" in share menu
5. Tap it
6. File uploads automatically!
```

---

## 🎯 What You'll See

### Before:
```
Google Recorder → Share → 
├─ Gmail
├─ Telegram  
├─ Messages
└─ ...
```

### After:
```
Google Recorder → Share →
├─ Gmail
├─ Telegram
├─ Solid Explorer ← NEW! Uploads to SFTP
└─ ...
```

---

## 🔄 Your New Workflow

```
1. Record voice note
   └─ Tap microphone, speak, stop

2. Share to SFTP
   └─ Tap "Share" → "Solid Explorer"

3. Wait ~30 seconds
   └─ n8n processes automatically

4. Check Vikunja
   └─ Tasks appear!
```

**Total user actions: 2 taps**  
**Total time: ~15 seconds**

---

## 🚀 Even Faster: Tasker Automation

Want ZERO manual uploads? See `PHONE_SHARE_SETUP.md` for:
- Tasker setup (~$6, 20 min)
- Auto-upload on recording
- Background notifications
- Completely hands-free!

---

## 📊 Time Savings

**Before (manual SFTP upload):**
- Open file manager
- Find recording
- Connect to SFTP
- Navigate to folder
- Upload file
- **Total: ~60 seconds, 8 steps**

**After (with share menu):**
- Tap "Share"
- Tap "Solid Explorer"
- **Total: ~15 seconds, 2 taps**

**Savings: 75% faster!**

---

## 💡 Quick Tips

1. **Pin to Favorites:** In Solid Explorer, long-press your SFTP connection and "Pin to favorites" for faster access

2. **Test Connection:** Before recording important notes, test with a dummy file to ensure SFTP is working

3. **Check n8n:** After first upload, check n8n executions to verify workflow triggers

4. **Battery Optimization:** Disable battery optimization for Solid Explorer to ensure reliable uploads

---

## 🔧 Troubleshooting

### "Solid Explorer not in share menu"
- Restart Solid Explorer app
- Go to Android Settings → Apps → Default Apps → Clear defaults
- Try again

### "Upload fails"
- Check WiFi/network connection
- Test SFTP connection in Solid Explorer directly
- Verify SFTPGo server is running
- Check username/password

### "n8n doesn't detect file"
- Verify file uploaded to /inbox folder
- Check n8n workflow is active
- Wait full 60 seconds (polling interval)
- Check n8n execution logs

---

## ✅ You're Done!

Now every voice note is just 2 taps away from becoming organized tasks!

For advanced automation, see:
- **PHONE_SHARE_SETUP.md** - Full guide with all options
- **SFTPGO_APPROACH.md** - Complete SFTP setup

---

*Created: October 29, 2025*  
*Setup time: 5 minutes*  
*Recommended app: Solid Explorer*


