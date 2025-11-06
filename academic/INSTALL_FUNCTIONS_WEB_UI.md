# 🔧 Install Open WebUI Functions via Web UI

**Your version of Open WebUI manages functions through the web interface, not the filesystem.**

---

## ✅ Good News: RAG is Already Working!

- ✅ ChromaDB v1.1.0 installed
- ✅ Vector database configured
- ✅ 4 collections with 16 documents already uploaded
- ✅ Ready to use!

---

## 📝 How to Add Functions

### Step 1: Access Functions Page

1. Go to: https://ai.opshub.host/
2. Click your **profile icon** (top right)
3. Go to **Admin Panel**
4. Click **Functions** in the sidebar

### Step 2: Create New Function

For each function, click **"+ Create New Function"** and use the code below:

---

## 🎨 Function 1: Voice to Blog Post

```python
"""
title: Voice to Blog Post
author: open-webui
description: Convert voice note transcripts into polished blog posts
version: 1.0.0
"""

from pydantic import BaseModel, Field
from typing import Optional


class Tools:
    def __init__(self):
        pass

    def voice_to_blog_post(
        self,
        transcript: str = Field(..., description="The voice note transcript"),
        tone: str = Field(
            default="professional",
            description="Tone of the blog post: professional, casual, technical, friendly, formal"
        ),
        length: str = Field(
            default="medium",
            description="Length of post: short (300w), medium (600w), long (1000w)"
        )
    ) -> str:
        """
        Convert a voice note transcript into a polished blog post with proper structure,
        engaging introduction, clear sections, and professional conclusion.
        
        :param transcript: The raw voice note transcript
        :param tone: Desired tone (professional, casual, technical, friendly, formal)
        :param length: Desired length (short 300w, medium 600w, long 1000w)
        :return: Formatted blog post
        """
        
        word_counts = {
            "short": "approximately 300 words",
            "medium": "approximately 600 words",
            "long": "approximately 1000 words"
        }
        
        target_length = word_counts.get(length, "approximately 600 words")
        
        prompt = f"""Transform this voice note transcript into a polished blog post:

Transcript:
{transcript}

Requirements:
- Tone: {tone}
- Length: {target_length}
- Include: engaging title, clear introduction, well-structured body with subheadings, conclusion
- Style: Natural flow, remove filler words, maintain authenticity of ideas
- Format: Use markdown (##, ###, **bold**, *italic*, bullet points, numbered lists)
- SEO: Include relevant keywords naturally

Create the blog post now:"""

        # Return the prompt for the LLM to process
        return prompt


class Action:
    def __init__(self):
        self.tools = Tools()

    def action(
        self,
        body: dict,
        __event_emitter__=None,
        __user__=None,
        __model__=None
    ) -> Optional[dict]:
        """Execute the voice to blog post conversion"""
        # This function is called when the tool is invoked
        # The actual LLM processing happens through the return value
        return None
```

**How to use:**
1. Upload voice transcript (`.txt` file)
2. In chat, type: `/voice_to_blog_post tone="casual" length="medium"`
3. Paste your transcript
4. Get polished blog post!

---

## 📊 Function 2: Voice to Meeting Notes

```python
"""
title: Voice to Meeting Notes
author: open-webui
description: Convert meeting transcripts into structured notes with action items
version: 1.0.0
"""

from pydantic import BaseModel, Field
from typing import Optional


class Tools:
    def __init__(self):
        pass

    def voice_to_meeting_notes(
        self,
        transcript: str = Field(..., description="The meeting transcript"),
        meeting_title: str = Field(
            default="Meeting Notes",
            description="Title of the meeting"
        ),
        format_style: str = Field(
            default="standard",
            description="Format style: standard, executive, detailed"
        )
    ) -> str:
        """
        Convert a meeting transcript into organized notes with action items,
        decisions, and key discussion points.
        
        :param transcript: The raw meeting transcript
        :param meeting_title: Title of the meeting
        :param format_style: Desired format (standard, executive, detailed)
        :return: Formatted meeting notes
        """
        
        format_instructions = {
            "standard": "Include all sections with moderate detail",
            "executive": "Focus on decisions and action items, brief discussion summary",
            "detailed": "Comprehensive notes with full discussion details and context"
        }
        
        style_instruction = format_instructions.get(format_style, format_instructions["standard"])
        
        prompt = f"""Transform this meeting transcript into structured meeting notes:

Transcript:
{transcript}

Meeting Title: {meeting_title}
Format Style: {format_style} ({style_instruction})

Create meeting notes with these sections:

## {meeting_title}
**Date:** [Extract or use today's date]
**Attendees:** [Extract from transcript or mark as "See transcript"]

### Summary
[2-3 sentence overview of the meeting]

### Key Discussion Points
- [Main topics discussed]
- [Important points raised]
- [Decisions made]

### Action Items
| Task | Assigned To | Due Date | Priority |
|------|-------------|----------|----------|
| [Extracted actions] | [Person] | [Date if mentioned] | [High/Med/Low] |

### Decisions Made
- [Key decisions]
- [Agreements reached]

### Next Steps
- [What happens next]
- [Follow-up items]

### Notes & Context
[Additional relevant information]

Format the notes now:"""

        return prompt


class Action:
    def __init__(self):
        self.tools = Tools()

    def action(
        self,
        body: dict,
        __event_emitter__=None,
        __user__=None,
        __model__=None
    ) -> Optional[dict]:
        """Execute the meeting notes conversion"""
        return None
```

**How to use:**
1. Upload meeting transcript
2. Type: `/voice_to_meeting_notes meeting_title="Weekly Standup" format_style="standard"`
3. Paste transcript
4. Get organized meeting notes!

---

## 📔 Function 3: Voice to Journal

```python
"""
title: Voice to Journal
author: open-webui
description: Convert voice notes into structured journal entries
version: 1.0.0
"""

from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class Tools:
    def __init__(self):
        pass

    def voice_to_journal(
        self,
        transcript: str = Field(..., description="The voice note transcript"),
        entry_type: str = Field(
            default="general",
            description="Type of journal entry: general, gratitude, reflection, daily_log, idea"
        ),
        include_prompts: bool = Field(
            default=False,
            description="Include reflection prompts at the end"
        )
    ) -> str:
        """
        Convert a voice note into a structured journal entry with proper formatting
        and optional reflection prompts.
        
        :param transcript: The raw voice note transcript
        :param entry_type: Type of entry (general, gratitude, reflection, daily_log, idea)
        :param include_prompts: Whether to add reflection prompts
        :return: Formatted journal entry
        """
        
        today = datetime.now().strftime("%B %d, %Y")
        
        entry_templates = {
            "general": {
                "title": "Daily Journal Entry",
                "sections": ["Thoughts", "Events", "Feelings", "Insights"]
            },
            "gratitude": {
                "title": "Gratitude Journal",
                "sections": ["Today I'm Grateful For", "Why It Matters", "Reflection"]
            },
            "reflection": {
                "title": "Reflection",
                "sections": ["What Happened", "How I Feel", "What I Learned", "Moving Forward"]
            },
            "daily_log": {
                "title": "Daily Log",
                "sections": ["Accomplishments", "Challenges", "Tomorrow's Focus"]
            },
            "idea": {
                "title": "Idea Capture",
                "sections": ["The Idea", "Why It's Interesting", "Next Steps", "Related Thoughts"]
            }
        }
        
        template = entry_templates.get(entry_type, entry_templates["general"])
        
        prompt = f"""Transform this voice note into a {entry_type} journal entry:

Voice Note:
{transcript}

Format as:

# {template['title']}
**Date:** {today}

{chr(10).join([f"### {section}{chr(10)}[Extract and organize relevant content]{chr(10)}" for section in template['sections']])}

"""

        if include_prompts:
            prompt += """
### Reflection Prompts
- What am I learning about myself from this?
- What would I do differently next time?
- How does this connect to my larger goals?
"""

        prompt += """
Important:
- Preserve the authentic voice and emotions from the transcript
- Organize thoughts coherently
- Add paragraph breaks for readability
- Keep the personal tone
- Remove filler words but maintain natural flow

Create the journal entry now:"""

        return prompt


class Action:
    def __init__(self):
        self.tools = Tools()

    def action(
        self,
        body: dict,
        __event_emitter__=None,
        __user__=None,
        __model__=None
    ) -> Optional[dict]:
        """Execute the journal entry conversion"""
        return None
```

**How to use:**
1. Upload voice note transcript
2. Type: `/voice_to_journal entry_type="reflection" include_prompts=true`
3. Paste transcript
4. Get beautifully formatted journal entry!

---

## 📋 Installation Checklist

- [ ] Go to https://ai.opshub.host/admin/functions
- [ ] Create "Voice to Blog Post" function
- [ ] Create "Voice to Meeting Notes" function
- [ ] Create "Voice to Journal" function
- [ ] Test each function with a sample transcript
- [ ] Verify outputs are high quality

---

## 🧪 Testing

### Test with Sample Transcript:

```
This is a test transcript. Today I had some interesting thoughts about 
productivity. I realized that batching similar tasks together really helps 
maintain focus. For example, I processed all my emails in one block this 
morning instead of checking throughout the day. This freed up mental energy 
for deep work. I think I'll try applying this principle to other areas too.
```

### Test Each Function:

1. **Blog Post:**
   ```
   /voice_to_blog_post tone="casual" length="short"
   [paste test transcript]
   ```

2. **Meeting Notes:**
   ```
   /voice_to_meeting_notes meeting_title="Productivity Discussion"
   [paste test transcript]
   ```

3. **Journal:**
   ```
   /voice_to_journal entry_type="reflection"
   [paste test transcript]
   ```

---

## 💡 Pro Tips

### For Best Results:

1. **Upload files first** (easier than pasting)
2. **Use the function commands** to get structured output
3. **Experiment with parameters** to find your preferred style
4. **Save good prompts** for reuse

### Advanced Usage:

**Chain functions:**
```
1. Upload transcript
2. Use /voice_to_blog_post to create draft
3. Ask: "Make this more technical"
4. Ask: "Add SEO keywords for organizational learning"
```

**Batch processing:**
```
1. Upload multiple transcripts
2. Process each with same function
3. Combine outputs
```

---

## 🎯 What's Already Working

✅ **RAG (Documents):**
- ChromaDB v1.1.0 installed
- 4 collections active
- 16 documents uploaded
- Ready for semantic search

**Try RAG queries:**
- "What does my rubric say about communication plans?"
- "Summarize the key concepts from my course overview"
- "Find all mentions of SMART objectives"

---

## 📞 Need Help?

**Functions not appearing?**
- Refresh the page
- Check Admin → Functions list
- Verify no syntax errors in the code

**Functions not working?**
- Check OpenAI API key is configured
- Verify model (GPT-4o or GPT-5) is selected
- Try with shorter transcript first

**Want to customize?**
- Edit the function code
- Modify prompts and templates
- Adjust parameters

---

## 🚀 Next Steps

1. **Tonight:** Install all 3 functions (10 min)
2. **Test:** Try with sample transcripts (5 min)
3. **Use:** Process your real voice notes!
4. **Combine:** Use with RAG for maximum power

---

**Ready to install?** Go to https://ai.opshub.host/admin/functions and start creating! 🎉

