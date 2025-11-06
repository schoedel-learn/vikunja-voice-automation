# 🎓 Academic Tools & Setup

**Purpose:** Open WebUI configuration and academic tools for doctoral coursework  
**Created:** October 29, 2025  
**Course:** TAL 602 - Organizational Learning (University of Miami)

---

## 📂 Files in This Directory

### Team Charter (Due Nov 2, 2025)

**`TEAM_CHARTER_DRAFT.md`** - Complete team charter draft
- ✅ All 5 rubric sections (20% each)
- ✅ SMART language throughout
- ✅ Mission, objectives, communication plan
- ✅ Ground rules, quality standards
- ✅ Team roles (rotating) + conflict resolution
- ✅ Ready for team review and submission

**Status:** Ready for team input → finalize → submit

---

### Quick Win Tonight

**`QUICK_WIN_TONIGHT.md`** - 30-minute setup guide
- Tonight's action items
- Timeline and checklist
- What's already done
- What you need to do
- Success metrics

**Use this:** Your roadmap for tonight!

---

### Setup Scripts (Run Tomorrow with SSH)

**`setup-openwebui-rag.sh`** - RAG Setup Script
- Enables RAG (Retrieval Augmented Generation)
- Configures ChromaDB vector database
- Sets optimal parameters for academic use
- Creates document collections
- **Runtime:** ~5 minutes
- **Requires:** SSH access to ai.opshub.host

**`install-openwebui-functions.sh`** - Functions Installer
- Installs 3 voice note processing functions
- Copies from `../openwebui-functions/`
- Sets permissions and dependencies
- Restarts Open WebUI
- **Runtime:** ~3 minutes
- **Requires:** SSH access to ai.opshub.host

**Both scripts are executable and ready to run!**

---

### Troubleshooting & Guides

**`FIX_REPEAT_PENALTY_ERROR.md`** - Fix for file upload error
- **Problem:** "Unknown parameter: 'repeat_penalty'" error
- **Cause:** Using local-model parameter with OpenAI
- **Solution:** Replace with `frequency_penalty` and `presence_penalty`
- **Time to fix:** 2 minutes
- **Do this FIRST** before anything else!

---

## 🚀 Quick Start

### Tonight (30 minutes):

1. **Fix the error** (2 min)
   ```
   Read: FIX_REPEAT_PENALTY_ERROR.md
   Go to: https://ai.opshub.host/workspace/models/edit?id=educate-barry
   Delete: repeat_penalty: 1.1
   Add: frequency_penalty: 0.3, presence_penalty: 0.0
   Save!
   ```

2. **Review team charter** (10 min)
   ```
   Open: TEAM_CHARTER_DRAFT.md
   Review all sections
   Note any needed changes
   ```

3. **Share with team** (5 min)
   ```
   Convert to Google Doc
   Share link with team
   Request feedback by Nov 1
   ```

4. **Reset SSH password** (5 min)
   ```
   Update credentials for 45.90.220.106
   Test connection
   Ready for tomorrow's setup
   ```

**Follow:** `QUICK_WIN_TONIGHT.md` for detailed steps

---

### Tomorrow (90 minutes - Academic Power Setup):

**Prerequisites:**
- ✅ SSH password reset and working
- ✅ Team charter shared (getting feedback)
- ✅ File upload error fixed

**Steps:**

1. **Enable RAG** (15 min)
   ```bash
   cd /Users/schoedel/Projects/vikunja-voice-automation/academic
   ./setup-openwebui-rag.sh
   ```

2. **Install Functions** (10 min)
   ```bash
   ./install-openwebui-functions.sh
   ```

3. **Create Collections** (10 min)
   - Go to: https://ai.opshub.host/admin/settings/documents
   - Create collections:
     - `course_materials` (chunk: 500, overlap: 50)
     - `research_papers` (chunk: 1000, overlap: 100)
     - `personal_notes` (chunk: 300, overlap: 30)

4. **Upload Documents** (15 min)
   - Course overview
   - Assignment instructions
   - Rubrics
   - Required readings
   - Your notes

5. **Test Everything** (20 min)
   - Test RAG queries
   - Test voice note functions
   - Verify semantic search
   - Test file uploads

6. **Optimize** (20 min)
   - Adjust chunk sizes if needed
   - Add metadata to documents
   - Test complex queries
   - Create custom prompts

---

## 📚 Reference Documentation

**For complete guides, see parent directory:**
- `../OPENWEBUI_ADVANCED_SETUP.md` - Full tools & functions guide
- `../OPENWEBUI_RAG_GUIDE.md` - Comprehensive RAG documentation
- `../openwebui-functions/README.md` - Function usage instructions

---

## 🎯 Goals & Expected Outcomes

### Tonight:
- ✅ File uploads working
- ✅ Team charter ready for review
- ✅ Team notified
- ✅ SSH access ready

### Tomorrow:
- ✅ RAG fully configured
- ✅ 3 functions installed and tested
- ✅ Course documents uploaded
- ✅ Semantic search working
- ✅ Ready for heavy academic use

### This Week:
- ✅ Team charter submitted (Nov 2)
- ✅ Using Open WebUI for all coursework
- ✅ Knowledge base growing
- ✅ Productivity boost for doctoral work

---

## 💡 Use Cases

### For Your Team Charter Assignment:

**Query your materials:**
```
"What does the rubric say about communication plans?"
"What SMART criteria should I use for objectives?"
"Give me examples of excellent conflict resolution processes"
```

**Get feedback:**
```
"Review my team charter draft against the rubric"
"What am I missing from the assignment requirements?"
"Score each section and tell me how to improve"
```

### For Future Assignments:

**Literature reviews:**
```
"Summarize key theories of organizational learning from my uploaded papers"
"What methodologies are common in team learning research?"
"Create a synthesis table of findings across these 10 papers"
```

**Assignment planning:**
```
"Break down this assignment into weekly tasks"
"Create a timeline based on the rubric and due date"
"What resources do I need to complete this successfully?"
```

**Writing assistance:**
```
"Convert my voice notes into academic prose"
"Check this paragraph for APA 7 formatting"
"Suggest improvements to this introduction"
```

---

## 🔧 Troubleshooting

### If RAG setup fails:
1. Check Docker container is running
2. Verify disk space available
3. Check OpenAI API key is set
4. Review setup script output for errors

### If functions don't appear:
1. Verify files copied correctly
2. Check container logs: `docker logs open-webui`
3. Restart container manually
4. Check file permissions

### If file uploads still fail:
1. Verify `repeat_penalty` is removed
2. Clear browser cache
3. Try different browser
4. Check browser console (F12) for errors

### If queries return poor results:
1. Adjust chunk size (smaller for facts, larger for concepts)
2. Add more metadata to documents
3. Try different embedding model
4. Enable reranking

**For detailed troubleshooting:** See `../OPENWEBUI_RAG_GUIDE.md`

---

## 📊 Progress Tracking

### Week 1 (Oct 28 - Nov 3):
- [x] Create team charter draft
- [x] Create setup scripts
- [ ] Fix repeat_penalty error
- [ ] Enable RAG
- [ ] Install functions
- [ ] Upload course documents
- [ ] Submit team charter (Nov 2)

### Week 2 (Nov 4 - Nov 10):
- [ ] Use RAG for project 2 research
- [ ] Create custom academic tools
- [ ] Build comprehensive course knowledge base
- [ ] Test voice-to-task workflow

### Ongoing:
- [ ] Upload all course readings
- [ ] Add personal notes and reflections
- [ ] Grow knowledge base
- [ ] Refine queries and prompts

---

## 🎓 Academic Integrity Note

**Open WebUI as a Learning Tool:**

✅ **Appropriate uses:**
- Organizing and searching your own notes
- Summarizing readings you've already done
- Getting feedback on drafts
- Creating outlines and structure
- APA formatting checks
- Time management and planning

❌ **Inappropriate uses:**
- Submitting AI-generated text as your own work
- Using AI instead of doing required readings
- Having AI write entire assignments
- Bypassing learning objectives

**Remember:** AI is a tool to enhance your learning, not replace it. Always cite AI assistance when required by your institution.

---

## 📞 Support

**Issues with scripts?**
- Check script output for specific errors
- Verify prerequisites (Docker, SSH access)
- Review setup guides in parent directory

**Need help with team charter?**
- Draft already meets rubric requirements
- Focus on team-specific customization
- Get feedback from team members

**Questions about RAG or functions?**
- See comprehensive guides in parent directory
- Test with simple queries first
- Build complexity gradually

---

## 🎉 You're Set Up for Success!

Everything is ready for tonight and tomorrow. Just follow the steps in `QUICK_WIN_TONIGHT.md` and you'll be up and running!

**Key files to open right now:**
1. `QUICK_WIN_TONIGHT.md` - Your roadmap
2. `FIX_REPEAT_PENALTY_ERROR.md` - Fix the error first!
3. `TEAM_CHARTER_DRAFT.md` - Review this tonight

**Tomorrow you'll use:**
1. `setup-openwebui-rag.sh` - Enable RAG
2. `install-openwebui-functions.sh` - Install functions

---

**Let's make this semester easier with powerful AI tools!** 🚀📚

