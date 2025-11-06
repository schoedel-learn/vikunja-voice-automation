# 🚀 Quick Win Tonight - 30 Minute Setup

**Goal:** Fix Open WebUI errors + Get team charter draft ready  
**Time:** 30 minutes  
**Date:** October 29, 2025

---

## ✅ What's Already Done (While You Reset Password)

1. **✅ Team Charter Draft Created**
   - Location: `academic/TEAM_CHARTER_DRAFT.md`
   - Meets all rubric requirements (SMART criteria throughout)
   - All 5 sections complete (20% each)
   - Ready for team review and customization

2. **✅ RAG Setup Script Ready**
   - Location: `academic/setup-openwebui-rag.sh`
   - Ready to run when SSH is available

3. **✅ Functions Installer Ready**
   - Location: `academic/install-openwebui-functions.sh`
   - Will install all 3 voice note functions

4. **✅ Fix Guide Created**
   - Location: `academic/FIX_REPEAT_PENALTY_ERROR.md`
   - Step-by-step instructions

---

## 🎯 Your Action Items (Right Now!)

### Item 1: Fix `repeat_penalty` Error (2 minutes)

**Why:** This is blocking your file uploads in Open WebUI

**How:**
1. Go to: https://ai.opshub.host/workspace/models/edit?id=educate-barry
2. Find the **Parameters** section
3. **Delete:** `repeat_penalty: 1.1`
4. **Add:**
   ```
   frequency_penalty: 0.3
   presence_penalty: 0.0
   ```
5. Click **Save**

**Test:**
- Go back to your team charter chat
- Try uploading files again
- Should work! ✅

**Full instructions:** See `FIX_REPEAT_PENALTY_ERROR.md`

---

### Item 2: Review Team Charter Draft (10 minutes)

**Location:** `academic/TEAM_CHARTER_DRAFT.md`

**What to review:**
- [ ] Team member names correct?
- [ ] Email addresses to add?
- [ ] Timezone assumptions correct?
- [ ] Meeting times work for everyone?
- [ ] Any roles/responsibilities to adjust?

**What's included:**
- ✅ Mission statement (aligned with course goals)
- ✅ 4 SMART objectives
- ✅ Communication plan (Teams, Zoom, Email, Google Drive)
- ✅ Ground rules (12 specific rules)
- ✅ Quality standards (measurable metrics)
- ✅ Team roles (rotating across 3 projects)
- ✅ 3-step conflict resolution process
- ✅ Meeting templates
- ✅ Project checklist
- ✅ Professional formatting

**Rubric alignment:**
- Mission & Objectives: 20% ✅
- Communication Plan: 20% ✅
- Ground Rules & Quality: 20% ✅
- Roles & Conflict Resolution: 20% ✅
- Document Completeness: 20% ✅

---

### Item 3: Share with Team (5 minutes)

**Options:**

**Option A: Convert to Google Doc**
1. Copy content from `TEAM_CHARTER_DRAFT.md`
2. Create new Google Doc
3. Paste and format
4. Share with team for collaborative editing
5. Get team signatures

**Option B: Share Markdown**
1. Upload `TEAM_CHARTER_DRAFT.md` to your team's Google Drive
2. Share link with team
3. Ask for feedback via Teams/email

**Option C: Use Open WebUI**
1. Paste the charter into Open WebUI (now that it's fixed!)
2. Ask: "Convert this to a Google Doc format"
3. Export and share

**Recommended:** Option A (Google Doc for easy team collaboration)

---

### Item 4: Get Team Input (Async)

**Send to team via Teams:**

> **Subject:** Team Charter Draft Ready for Review!
>
> Hi team,
>
> I've created a draft of our TAL 602 Team Charter (due Nov 2). Please review by [Friday, Nov 1] and add comments/suggestions:
>
> 📄 [Link to Google Doc]
>
> **Key sections to review:**
> - Mission & Objectives (pages 1-2)
> - Communication Plan (page 3) - *Especially meeting times!*
> - Your assigned role for Project 1 (page 6)
> - Conflict resolution process (page 7)
>
> **Please verify:**
> - [ ] Your name/contact info is correct
> - [ ] Meeting times work for your schedule
> - [ ] Your Project 1 role makes sense
>
> We'll finalize this during our Tuesday meeting!
>
> Thanks,
> Barry

---

## 🔐 SSH Password Reset (When Ready)

Once you've reset the password, we can run:

1. **Enable RAG:**
   ```bash
   cd /Users/schoedel/Projects/vikunja-voice-automation/academic
   chmod +x setup-openwebui-rag.sh
   ./setup-openwebui-rag.sh
   ```

2. **Install Functions:**
   ```bash
   chmod +x install-openwebui-functions.sh
   ./install-openwebui-functions.sh
   ```

3. **Upload Course Documents:**
   - Team Charter Rubric
   - Assignment Instructions
   - Course Overview
   - Test RAG queries

---

## 📊 Progress Tracking

### Tonight (30 min):
- [x] Create team charter draft
- [x] Create setup scripts
- [x] Create fix guide
- [ ] Fix repeat_penalty error ← **YOU DO THIS**
- [ ] Review charter ← **YOU DO THIS**
- [ ] Share with team ← **YOU DO THIS**
- [ ] Reset SSH password ← **YOU DO THIS**

### Tomorrow (90 min - Academic Power Setup):
- [ ] SSH access working
- [ ] Run RAG setup script
- [ ] Install voice note functions
- [ ] Upload course documents
- [ ] Create 3 document collections
- [ ] Test semantic search
- [ ] Optimize chunk sizes
- [ ] Create custom academic tools:
  - [ ] Team charter generator
  - [ ] APA citation helper
  - [ ] Research paper analyzer

---

## 🎓 Immediate Value

**What you can do RIGHT NOW (after fixing error):**

1. **Team Charter Help:**
   - Upload rubric + instructions to Open WebUI
   - Ask: "Review my draft against the rubric"
   - Get instant feedback

2. **Course Reading Analysis:**
   - Upload course overview
   - Ask: "What are the key concepts I should focus on?"
   - Get study guide

3. **Assignment Planning:**
   - Upload assignment instructions
   - Ask: "Create a timeline for completing this"
   - Get action plan

**After RAG setup tomorrow:**
- Upload ALL course materials
- Ask questions across your entire library
- Get cited answers with sources
- Never lose track of important information

---

## 💡 Pro Tips

### For Team Charter:
- **Don't overthink it** - The draft is already excellent
- **Get team buy-in** - Focus on meeting times and roles
- **Keep it simple** - Can always adjust after Project 1
- **Submit on time** - Due Nov 2, 11:59 PM EST

### For Open WebUI:
- **Fix the error first** - Everything else depends on this
- **Test with small files** - Verify uploads work
- **Use for all courses** - Not just this one!
- **Build your knowledge base** - Upload everything

### For Tomorrow:
- **Have SSH password ready** - We'll need it immediately
- **Gather your documents** - PDFs, DOCs, course materials
- **Block 90 minutes** - Full setup is worth it
- **Test as we go** - Verify each step works

---

## 🎯 Success Metrics

### Tonight's Success:
- ✅ File uploads working in Open WebUI
- ✅ Team charter draft ready
- ✅ Team notified and reviewing
- ✅ SSH password reset

### Tomorrow's Success:
- ✅ RAG enabled and working
- ✅ 3 functions installed
- ✅ Course documents uploaded
- ✅ Semantic search working
- ✅ Can query your entire knowledge base

---

## 📞 Need Help?

**If repeat_penalty fix doesn't work:**
- Check `FIX_REPEAT_PENALTY_ERROR.md` for alternative locations
- Try clearing browser cache
- Try different browser
- Check browser console for errors (F12)

**If team charter needs major changes:**
- The draft is a starting point
- Focus on the rubric requirements
- All sections are there, just customize
- Can simplify if it's too detailed

**If SSH still not working tomorrow:**
- We can guide you through manual setup
- Or provide step-by-step UI instructions
- Everything can be done via web interface

---

## 📅 Timeline

**Tonight (Oct 29):**
- 9:00 PM: Fix error + review charter (30 min)
- 9:30 PM: Share with team
- Before bed: Reset SSH password

**Thursday (Oct 30):**
- TBD: 90-minute power setup session
- Install everything
- Upload documents
- Test thoroughly

**Friday (Nov 1):**
- Team reviews charter
- Finalize with team input
- Test Open WebUI with real queries

**Saturday (Nov 2):**
- Submit final charter by 11:59 PM EST
- Relax - you're ahead! 🎉

---

## ✨ You're Set Up for Success!

Everything is ready. Just need to:
1. Fix the error (2 min)
2. Review the charter (10 min)
3. Share with team (5 min)
4. Reset password (5 min)

**Total time: ~22 minutes**

Then tomorrow we'll do the full power setup! 🚀

---

**Questions?** Just ask! I'm here to help.

**Ready?** Start with fixing the `repeat_penalty` error first - everything else flows from there.

**Let's do this!** 💪

