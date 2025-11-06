# 🎨 Multi-Purpose Voice Note Workflows

**Goal:** Use voice recordings for DIFFERENT purposes (tasks, blog posts, notes, etc.)

**Last Updated:** October 29, 2025

---

## 🎯 The Problem

**You don't want all recordings to become tasks!**

Some recordings are for:
- 📋 Tasks (Vikunja project management)
- 📝 Blog posts (via GPT-5)
- 📄 Meeting notes
- 🗒️ Journal entries
- 💭 Ideas to refine
- 🎙️ Transcriptions only
- 📚 Research notes

**Solution:** Multiple workflows with user choice!

---

## 🚀 Solution Overview

### Three Approaches (Pick What Fits):

1. **Multiple SFTP Folders** ⭐ BEST
   - Upload to different folders
   - Each folder triggers different n8n workflow
   - Most flexible and organized

2. **Multiple Share Targets**
   - Different apps for different purposes
   - Each app uploads to different location
   - Visual and intuitive

3. **Open WebUI Manual Processing** 🎨
   - Upload recording to Open WebUI directly
   - Choose what to do with it
   - Most control, requires manual steps

---

## 🏗️ Approach 1: Multiple SFTP Folders ⭐ RECOMMENDED

### Architecture:

```
📱 Google Recorder
  ↓ Share to SFTP
  ↓ Choose destination folder:
  ├─ /inbox/tasks → n8n → Vikunja (tasks)
  ├─ /inbox/blog → n8n → GPT-5 (blog post)
  ├─ /inbox/notes → n8n → Storage (just save)
  └─ /inbox/journal → n8n → Journal app
```

### Setup: SFTPGo Folders

#### On SFTPGo Server:

```bash
# Create folder structure
mkdir -p /home/voicenotes/inbox/tasks
mkdir -p /home/voicenotes/inbox/blog
mkdir -p /home/voicenotes/inbox/notes
mkdir -p /home/voicenotes/inbox/journal
mkdir -p /home/voicenotes/processed

# Set permissions
chown -R sftpgo:sftpgo /home/voicenotes
chmod 755 /home/voicenotes/inbox/*
```

### Setup: Solid Explorer Bookmarks

Create multiple SFTP bookmarks:

#### Bookmark 1: Voice → Tasks
```
Name: 📋 Voice Notes → Tasks
Host: your-sftpgo-server.com
Port: 2022
Username: voicenotes
Password: [password]
Initial path: /inbox/tasks
```

#### Bookmark 2: Voice → Blog
```
Name: 📝 Voice Notes → Blog
Host: your-sftpgo-server.com
Port: 2022
Username: voicenotes
Password: [password]
Initial path: /inbox/blog
```

#### Bookmark 3: Voice → Notes
```
Name: 🗒️ Voice Notes → Notes
Host: your-sftpgo-server.com
Port: 2022
Username: voicenotes
Password: [password]
Initial path: /inbox/notes
```

#### Bookmark 4: Voice → Journal
```
Name: 📖 Voice Notes → Journal
Host: your-sftpgo-server.com
Port: 2022
Username: voicenotes
Password: [password]
Initial path: /inbox/journal
```

### User Experience:

```
1. Record voice note
2. Tap "Share"
3. Tap "Solid Explorer"
4. CHOOSE FOLDER:
   ├─ Tap "📋 Voice Notes → Tasks" for tasks
   ├─ Tap "📝 Voice Notes → Blog" for blog posts
   ├─ Tap "🗒️ Voice Notes → Notes" for storage
   └─ Tap "📖 Voice Notes → Journal" for journal
5. Upload
6. Done!
```

### n8n Workflows:

Create separate workflow for each purpose:

#### Workflow 1: Tasks (existing)
```
Trigger: SFTP folder watch /inbox/tasks
Action: GPT-5 → Extract tasks → Vikunja
```

#### Workflow 2: Blog Posts (NEW)
```
Trigger: SFTP folder watch /inbox/blog
Actions:
  1. Read transcript
  2. Send to GPT-5 with prompt:
     "Convert this voice note into a blog post:
      - Add engaging title
      - Structure with headings
      - Professional tone
      - Add conclusion
      - Format in Markdown"
  3. Save to blog folder or CMS
  4. Send notification with preview
```

#### Workflow 3: Notes (NEW)
```
Trigger: SFTP folder watch /inbox/notes
Actions:
  1. Read transcript
  2. Add timestamp
  3. Save to notes folder
  4. Index for search (optional)
```

#### Workflow 4: Journal (NEW)
```
Trigger: SFTP folder watch /inbox/journal
Actions:
  1. Read transcript
  2. Add date/time
  3. Send to GPT-5 for formatting
  4. Save to journal folder
  5. Tag with mood/topics (optional)
```

---

## 🎨 Approach 2: Multiple Share Targets

### Use Different Apps for Different Purposes

```
Share Menu:
├─ "📋 Solid Explorer" → Tasks
├─ "📝 HTTP Shortcuts - Blog" → Blog workflow
├─ "🗒️ FX File Explorer" → Notes storage
└─ "📖 Tasker - Journal" → Journal workflow
```

### Setup:

1. **Solid Explorer** for tasks (existing setup)
2. **HTTP Shortcuts** for blog posts (configure endpoint)
3. **FX File Explorer** for simple storage
4. **Tasker** for journal (with custom processing)

Each app can have different icon/name in share menu for clarity.

---

## 🖥️ Approach 3: Open WebUI Manual Processing ⭐ FLEXIBLE

### For Maximum Control & New Features

Use Open WebUI as a central hub for ALL voice processing.

### Architecture:

```
📱 Record voice note
  ↓ Get transcript (.txt file)
  ↓ Upload to Open WebUI chat interface
  ↓ Choose function:
  ├─ create_tasks_from_voice → Vikunja
  ├─ voice_to_blog_post → Blog draft
  ├─ voice_to_meeting_notes → Formatted notes
  ├─ voice_to_journal_entry → Journal
  └─ voice_to_research_notes → Knowledge base
```

### Setup: Open WebUI Functions

I'll create multiple functions for different purposes.

#### Function 1: Tasks (existing)
You already have this working!

#### Function 2: Blog Post Generator (NEW)

```python
"""
title: Voice to Blog Post
author: open-webui
version: 1.0
description: Convert voice note transcript into blog post
"""

from pydantic import BaseModel, Field
from typing import Optional
import requests
import os


class Tools:
    class Valves(BaseModel):
        OPENAI_API_KEY: str = Field(
            default="",
            description="OpenAI API Key for GPT-5"
        )

    def __init__(self):
        self.valves = self.Valves()

    def voice_to_blog_post(
        self,
        transcript: str,
        tone: str = "professional",
        length: str = "medium",
        __user__: dict = {}
    ) -> str:
        """
        Convert voice note transcript into blog post.
        
        :param transcript: The voice note transcript text
        :param tone: Blog tone (casual, professional, technical, friendly)
        :param length: Post length (short=300w, medium=600w, long=1000w)
        :return: Formatted blog post in Markdown
        """
        
        # Define length targets
        length_map = {
            "short": "approximately 300 words",
            "medium": "approximately 600 words", 
            "long": "approximately 1000 words"
        }
        
        target_length = length_map.get(length, "approximately 600 words")
        
        # Create blog post prompt
        prompt = f"""Convert this voice note transcript into a polished blog post.

Voice note transcript:
\"\"\"{transcript}\"\"\"

Requirements:
- Tone: {tone}
- Length: {target_length}
- Add an engaging title
- Structure with clear headings (## for H2, ### for H3)
- Add an introduction hook
- Use short paragraphs (2-3 sentences max)
- Include bullet points where appropriate
- Add a strong conclusion
- Format in Markdown
- Make it flow naturally (remove filler words, clean up rambling)
- Keep the core message and insights

Output ONLY the blog post, starting with the title."""

        try:
            # Call GPT-5 API
            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {self.valves.OPENAI_API_KEY}",
                    "Content-Type": "application/json"
                },
                json={
                    "model": "gpt-5",
                    "messages": [
                        {
                            "role": "system",
                            "content": "You are an expert blog writer and editor. Convert rambling voice notes into polished, engaging blog posts."
                        },
                        {
                            "role": "user",
                            "content": prompt
                        }
                    ],
                    "temperature": 0.7
                },
                timeout=60
            )
            
            if response.status_code == 200:
                blog_post = response.json()["choices"][0]["message"]["content"]
                return f"""✅ **Blog Post Generated!**

---

{blog_post}

---

**Instructions:**
- Copy the blog post above
- Edit as needed in your editor
- Add images/media if desired
- Publish to your blog platform

**Want revisions?** Ask me to:
- Make it longer/shorter
- Change the tone
- Adjust specific sections
- Add more examples
"""
            else:
                return f"❌ Error: API returned {response.status_code}\n{response.text}"
                
        except Exception as e:
            return f"❌ Error generating blog post: {str(e)}"
```

#### Function 3: Meeting Notes (NEW)

```python
"""
title: Voice to Meeting Notes
author: open-webui
version: 1.0
description: Convert meeting transcript into structured notes
"""

from pydantic import BaseModel, Field
import requests


class Tools:
    class Valves(BaseModel):
        OPENAI_API_KEY: str = Field(
            default="",
            description="OpenAI API Key for GPT-5"
        )

    def __init__(self):
        self.valves = self.Valves()

    def voice_to_meeting_notes(
        self,
        transcript: str,
        meeting_title: str = "Meeting",
        __user__: dict = {}
    ) -> str:
        """
        Convert meeting transcript into structured notes.
        
        :param transcript: The meeting transcript
        :param meeting_title: Title/topic of the meeting
        :return: Structured meeting notes
        """
        
        prompt = f"""Convert this meeting transcript into structured notes.

Meeting: {meeting_title}
Transcript:
\"\"\"{transcript}\"\"\"

Create meeting notes with these sections:
1. **Meeting Overview**
   - Date & Participants
   - Purpose
   
2. **Key Discussion Points**
   - Main topics covered
   - Important context
   
3. **Decisions Made**
   - Clear list of decisions
   
4. **Action Items**
   - Who is responsible
   - What needs to be done
   - When (if mentioned)
   
5. **Next Steps**
   - Follow-up items
   - Next meeting (if scheduled)

Format in Markdown. Be concise but complete."""

        try:
            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {self.valves.OPENAI_API_KEY}",
                    "Content-Type": "application/json"
                },
                json={
                    "model": "gpt-5",
                    "messages": [
                        {"role": "system", "content": "You are an expert at taking structured meeting notes."},
                        {"role": "user", "content": prompt}
                    ],
                    "temperature": 0.3
                },
                timeout=60
            )
            
            if response.status_code == 200:
                notes = response.json()["choices"][0]["message"]["content"]
                return f"""✅ **Meeting Notes Generated!**

---

{notes}

---

**Want to:**
- Add these action items to Vikunja? (paste action items)
- Send notes to team? (copy and email)
- Save to documentation? (export to your wiki)
"""
            else:
                return f"❌ Error: {response.status_code}"
                
        except Exception as e:
            return f"❌ Error: {str(e)}"
```

#### Function 4: Journal Entry (NEW)

```python
"""
title: Voice to Journal Entry
author: open-webui
version: 1.0
description: Convert voice note into journal entry
"""

from pydantic import BaseModel, Field
from datetime import datetime
import requests


class Tools:
    class Valves(BaseModel):
        OPENAI_API_KEY: str = Field(
            default="",
            description="OpenAI API Key for GPT-5"
        )

    def __init__(self):
        self.valves = self.Valves()

    def voice_to_journal(
        self,
        transcript: str,
        entry_type: str = "general",
        __user__: dict = {}
    ) -> str:
        """
        Convert voice note into journal entry.
        
        :param transcript: Voice note transcript
        :param entry_type: Type (general, gratitude, reflection, daily)
        :return: Formatted journal entry
        """
        
        today = datetime.now().strftime("%A, %B %d, %Y")
        
        type_prompts = {
            "general": "Convert this into a personal journal entry. Keep the authentic voice and emotions.",
            "gratitude": "Extract gratitude moments and format as a gratitude journal entry.",
            "reflection": "Turn this into a reflective journal entry, exploring deeper insights and lessons.",
            "daily": "Format as a daily journal entry with events, thoughts, and highlights."
        }
        
        type_prompt = type_prompts.get(entry_type, type_prompts["general"])
        
        prompt = f"""{type_prompt}

Voice note:
\"\"\"{transcript}\"\"\"

Format as journal entry:
- Add date at top
- Keep authentic voice
- Organize thoughts
- Format for easy reading
- Keep personal tone
- Add emotional context if present

Output in Markdown."""

        try:
            response = requests.post(
                "https://api.openai.com/v1/chat/completions",
                headers={
                    "Authorization": f"Bearer {self.valves.OPENAI_API_KEY}",
                    "Content-Type": "application/json"
                },
                json={
                    "model": "gpt-5",
                    "messages": [
                        {"role": "system", "content": "You are a thoughtful journal assistant. Help format voice notes into meaningful journal entries while preserving authentic voice."},
                        {"role": "user", "content": prompt}
                    ],
                    "temperature": 0.7
                },
                timeout=60
            )
            
            if response.status_code == 200:
                entry = response.json()["choices"][0]["message"]["content"]
                return f"""✅ **Journal Entry Created**

---

# {today}

{entry}

---

**Save to:**
- Copy to your journal app
- Save to local file
- Add to digital journal

**Prompts:**
- "Expand on the part about..."
- "Add more detail about..."
- "Reflect deeper on..."
"""
            else:
                return f"❌ Error: {response.status_code}"
                
        except Exception as e:
            return f"❌ Error: {str(e)}"
```

---

## 🎯 Recommended Setup: Hybrid Approach

### Combine the Best of All Methods

#### For Tasks (Frequent, Automatic):
```
Use: SFTP folder /inbox/tasks
Flow: Record → Share → SFTP → n8n → Vikunja
Speed: Automatic, ~30 seconds
```

#### For Blog Posts (Occasional, Reviewed):
```
Use: Open WebUI function
Flow: Record → Copy transcript → Open WebUI → voice_to_blog_post()
Speed: Manual, 2-3 minutes (review and edit)
```

#### For Meeting Notes (As Needed):
```
Use: Open WebUI function
Flow: Record meeting → Copy transcript → Open WebUI → voice_to_meeting_notes()
Speed: Manual, 1-2 minutes
```

#### For Journal (Personal, Reflective):
```
Use: Open WebUI function OR SFTP folder
Flow: Record → Open WebUI → voice_to_journal() (for editing)
      OR Record → Share → SFTP /inbox/journal (for auto-save)
Speed: Manual for reflection, auto for quick entries
```

---

## 📋 Setup Checklist

### Phase 1: Multi-Folder SFTP
- [ ] Create folders on SFTPGo server
- [ ] Add multiple bookmarks in Solid Explorer
- [ ] Test upload to each folder

### Phase 2: n8n Workflows
- [ ] Keep existing tasks workflow
- [ ] Create blog post workflow (optional if using Open WebUI)
- [ ] Create notes storage workflow
- [ ] Create journal workflow

### Phase 3: Open WebUI Functions
- [ ] Install voice_to_blog_post function
- [ ] Install voice_to_meeting_notes function
- [ ] Install voice_to_journal function
- [ ] Configure OpenAI API keys
- [ ] Test each function

---

## 🎨 User Experience Examples

### Scenario 1: Task Creation (Quick)
```
🎙️ Record: "I need to finish the proposal, call John about the contract, 
           and schedule the team meeting for next week"

📱 Share → 📋 Voice Notes → Tasks
⏱️ Wait 30 seconds
✅ 3 tasks appear in Vikunja
```

### Scenario 2: Blog Post (Thoughtful)
```
🎙️ Record: [10 minute rambling about "The Future of AI in Healthcare"]

📱 Copy transcript text
💻 Open WebUI → voice_to_blog_post(transcript, tone="professional", length="long")
✍️ Review and edit generated blog post
📝 Publish to blog
```

### Scenario 3: Meeting Notes (Structured)
```
🎙️ Record: [30 minute team meeting discussion]

📱 Copy transcript
💻 Open WebUI → voice_to_meeting_notes(transcript, "Q4 Planning Meeting")
📋 Review notes
✅ Extract action items
📧 Share with team
```

### Scenario 4: Journal Entry (Personal)
```
🎙️ Record: [Personal reflections about the day]

Option A (Auto): Share → 📖 Voice Notes → Journal → Auto-saved
Option B (Refined): Copy → Open WebUI → voice_to_journal() → Review → Save
```

---

## 💡 Pro Tips

### 1. Use Prefixes in Recording Titles
```
Google Recorder automatically names files:
- "Recording_2025-10-29_14-30.txt" (generic)

You can rename before sharing:
- "TASK_project_ideas.txt" → Auto to tasks
- "BLOG_ai_healthcare.txt" → Process as blog
- "MEETING_q4_planning.txt" → Meeting notes
- "JOURNAL_daily.txt" → Journal entry
```

### 2. Create Templates in Open WebUI
```
Save common prompts:
- "Blog post about [topic] in professional tone"
- "Meeting notes from [meeting type]"
- "Gratitude journal for today"
```

### 3. Combine Automated + Manual
```
Quick tasks → Automatic SFTP
Everything else → Manual Open WebUI (for control)
```

### 4. Use n8n for Routing
```
Single SFTP folder, n8n routes based on filename:
- *_TASK_* → Vikunja workflow
- *_BLOG_* → Blog workflow
- *_NOTE_* → Storage workflow
- *_JOURNAL_* → Journal workflow
```

---

## 🔧 Advanced: Smart n8n Router

### Single Workflow, Multiple Outputs

Create one n8n workflow that routes based on folder or filename:

```javascript
// In n8n Code node
const filePath = $input.item.json.path;
const fileName = $input.item.json.filename;

// Determine purpose from path or filename
let purpose = 'unknown';

if (filePath.includes('/tasks/') || fileName.includes('_TASK_')) {
  purpose = 'tasks';
} else if (filePath.includes('/blog/') || fileName.includes('_BLOG_')) {
  purpose = 'blog';
} else if (filePath.includes('/meeting/') || fileName.includes('_MEETING_')) {
  purpose = 'meeting';
} else if (filePath.includes('/journal/') || fileName.includes('_JOURNAL_')) {
  purpose = 'journal';
}

return {
  json: {
    ...$input.item.json,
    purpose: purpose
  }
};
```

Then use n8n Switch node to route to appropriate sub-workflow.

---

## 🎉 Benefits of Multi-Purpose Setup

### Flexibility
- ✅ Choose purpose per recording
- ✅ Not locked into one use case
- ✅ Adapt as needs change

### Control
- ✅ Auto-process routine items (tasks)
- ✅ Manually review important items (blog posts)
- ✅ Full control over each recording

### Efficiency
- ✅ Quick path for tasks (2 taps, 30 sec)
- ✅ Thoughtful path for content (review and edit)
- ✅ Best tool for each job

### Scalability
- ✅ Easy to add new purposes
- ✅ Each workflow independent
- ✅ Can customize each differently

---

## 📞 Next Steps

### To Implement:

1. **Read this document** ← You are here
2. **Choose approach:**
   - Multi-folder SFTP (most flexible)
   - Multiple share targets (visual)
   - Open WebUI functions (maximum control)
   - Hybrid (recommended)
3. **Set up folders/functions**
4. **Test each workflow**
5. **Refine based on usage**

---

## 🚀 Quick Start: Hybrid Approach

### 1. Keep Existing Task Workflow
Your current setup works great for tasks - keep it!

### 2. Add Open WebUI Functions
Install the 3 new functions (blog, meeting notes, journal)

### 3. Use Case by Case
- Quick tasks → SFTP automatic
- Blog posts → Open WebUI (review first)
- Meeting notes → Open WebUI (structure)
- Journal → Either (auto-save or refined)

### 4. Expand as Needed
Add more folders or functions based on your usage patterns

---

*Created: October 29, 2025*  
*Purpose: Multiple workflows for different voice note purposes*  
*Recommended: Hybrid approach (SFTP for tasks, Open WebUI for content)*


