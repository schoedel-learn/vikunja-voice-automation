# 🎨 Open WebUI Functions for Voice Notes

**Purpose:** Convert voice note transcripts into different formats using GPT-5

**Created:** October 29, 2025

---

## 📦 Available Functions

### 1. `voice_to_blog_post.py` - Blog Post Generator
Convert rambling voice notes into polished blog posts.

**Features:**
- Multiple tone options (professional, casual, technical, friendly, inspirational)
- Length control (short/medium/long)
- SEO-friendly titles
- Proper Markdown formatting
- Ready to publish

**Usage:**
```python
voice_to_blog_post(
    transcript="Your voice note text here...",
    tone="professional",
    length="medium"
)
```

---

### 2. `voice_to_meeting_notes.py` - Meeting Notes Formatter
Transform meeting recordings into structured, actionable notes.

**Features:**
- Organized sections (overview, discussion, decisions, action items)
- Extract action items with owners and due dates
- Next steps and follow-up tracking
- Ready to share with team

**Usage:**
```python
voice_to_meeting_notes(
    transcript="Meeting recording transcript...",
    meeting_title="Q4 Planning Meeting"
)
```

---

### 3. `voice_to_journal.py` - Journal Entry Creator
Convert voice notes into formatted journal entries.

**Features:**
- Multiple journal types (general, gratitude, reflection, daily, goals, dream)
- Preserves authentic voice
- Organized and readable format
- Privacy-conscious

**Usage:**
```python
voice_to_journal(
    transcript="Today I've been thinking about...",
    entry_type="reflection"
)
```

---

## 🚀 Installation

### Step 1: Access Open WebUI

Go to: https://ai.opshub.host/

### Step 2: Install Functions

1. Click your profile icon (top-right)
2. Select "Workspace" → "Functions"
3. Click "+ Add Function"
4. Copy the entire contents of each `.py` file
5. Paste into the function editor
6. Click "Save"
7. Repeat for each function

### Step 3: Configure API Key

For each function:
1. Click the function name
2. Go to "Valves" tab
3. Enter your OpenAI API key
4. Click "Save"

---

## 💡 Usage Examples

### Blog Post Creation

**Voice Note:**
> "So today I've been thinking about the future of AI in healthcare, and I think there are three main areas where we'll see huge changes in the next five years..."

**Command:**
```
voice_to_blog_post(
    transcript="[paste transcript]",
    tone="professional",
    length="long"
)
```

**Result:** Professional 1000-word blog post with title, structure, and conclusion

---

### Meeting Notes

**Voice Note:**
> "[30 minutes of team meeting discussion]"

**Command:**
```
voice_to_meeting_notes(
    transcript="[paste transcript]",
    meeting_title="Q4 Planning Meeting"
)
```

**Result:** Structured notes with action items, decisions, and follow-up tasks

---

### Journal Entry

**Voice Note:**
> "Today was really intense. I'm grateful for..."

**Command:**
```
voice_to_journal(
    transcript="[paste transcript]",
    entry_type="gratitude"
)
```

**Result:** Formatted gratitude journal entry ready to save

---

## 🎯 Integration with Task Workflow

### Combined Workflow:

**For Quick Tasks:**
```
Record → Share → SFTP → n8n → Vikunja (automatic)
```

**For Blog Posts:**
```
Record → Copy transcript → Open WebUI → voice_to_blog_post()
```

**For Meeting Notes:**
```
Record → Copy transcript → Open WebUI → voice_to_meeting_notes()
```

**For Journal:**
```
Record → Copy transcript → Open WebUI → voice_to_journal()
```

---

## 🔐 Security & Privacy

### API Key Safety:
- Store API key in Open WebUI valves (encrypted)
- Never commit API key to Git
- Rotate keys regularly

### Data Privacy:
- Transcripts processed via OpenAI GPT-5
- Not stored by OpenAI (per API policy)
- Consider local models for maximum privacy

### Best Practices:
- Use strong Open WebUI password
- Enable 2FA if available
- Review generated content before sharing
- Don't include sensitive info in voice notes

---

## 📊 Cost Estimate

**Per Function Call:**
- Voice to Blog (long): ~$0.02-0.03
- Meeting Notes: ~$0.01-0.02
- Journal Entry: ~$0.01-0.02

**Monthly Estimate (Moderate Use):**
- 10 blog posts: ~$0.30
- 20 meeting notes: ~$0.30
- 30 journal entries: ~$0.45
- **Total: ~$1.05/month**

Much cheaper than subscription services!

---

## 🛠️ Customization

### Modify Prompts:

Each function has a `prompt` variable you can customize:

```python
prompt = f"""Your custom instructions here...

Transcript: {transcript}

Additional requirements...
"""
```

### Add New Functions:

Use these as templates to create:
- Email drafts from voice
- Social media posts
- Research summaries
- Creative writing
- And more!

---

## 🐛 Troubleshooting

### "Function not working"
- Check API key is configured
- Verify GPT-5 access on your OpenAI account
- Check API credits available
- Look at Open WebUI logs

### "Output is too short/long"
- Adjust length parameter
- Modify max_tokens in code
- Check transcript length

### "Wrong tone/style"
- Adjust tone parameter
- Modify system prompt
- Provide more context in transcript

### "API timeout"
- Shorten transcript
- Try again (server might be busy)
- Increase timeout value in code

---

## 📈 Future Enhancements

### Planned Features:
- [ ] Email draft generator
- [ ] Social media post creator
- [ ] Research note formatter
- [ ] Creative story writer
- [ ] Code documentation from voice
- [ ] Language translation
- [ ] Summary generator

### Want to Contribute?

Create new functions following the template:
1. Copy existing function as base
2. Modify prompt and logic
3. Test thoroughly
4. Share with community!

---

## 📞 Support

### Need Help?

- Check function code for inline comments
- Review `MULTI_PURPOSE_WORKFLOWS.md` for workflows
- Test with short transcripts first
- Check Open WebUI documentation

### Found a Bug?

- Check Open WebUI console for errors
- Verify API key and access
- Try with different transcript
- Review function logs

---

## 🎉 You Now Have:

✅ **3 powerful functions** for different purposes  
✅ **GPT-5 powered** processing  
✅ **Flexible workflows** for any voice note  
✅ **Full control** over what gets processed how  

**No more "all tasks or nothing" - choose the right tool for each recording!**

---

*Created: October 29, 2025*  
*Version: 1.0*  
*Status: Ready to use*


