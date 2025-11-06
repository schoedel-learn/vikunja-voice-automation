"""
title: Voice to Journal Entry
author: open-webui
version: 1.0
description: Convert voice note into formatted journal entry using GPT-5
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
        Convert voice note into a formatted journal entry.
        
        :param transcript: Voice note transcript
        :param entry_type: Type of journal entry - choose from: general, gratitude, reflection, daily, goals, dream
        :return: Formatted journal entry
        
        Example usage:
        voice_to_journal(
            transcript="Today was really interesting...",
            entry_type="daily"
        )
        """
        
        # Validate entry type
        valid_types = ["general", "gratitude", "reflection", "daily", "goals", "dream"]
        if entry_type not in valid_types:
            return f"❌ Invalid entry_type. Choose from: {', '.join(valid_types)}"
        
        today = datetime.now().strftime("%A, %B %d, %Y")
        time_now = datetime.now().strftime("%I:%M %p")
        
        # Define prompts for different journal types
        type_instructions = {
            "general": {
                "title": "Journal Entry",
                "instructions": "Convert into a personal journal entry. Keep the authentic voice and capture emotions and thoughts naturally. Organize the stream of consciousness into readable paragraphs."
            },
            "gratitude": {
                "title": "Gratitude Journal",
                "instructions": "Extract and emphasize things the speaker is grateful for. Format as a gratitude journal entry, highlighting positive moments, blessings, and appreciation. Group related gratitude items together."
            },
            "reflection": {
                "title": "Reflection Journal",
                "instructions": "Turn this into a reflective journal entry. Explore deeper insights, lessons learned, and personal growth. Add thoughtful questions or observations where appropriate. Emphasize self-awareness and introspection."
            },
            "daily": {
                "title": "Daily Log",
                "instructions": "Format as a daily journal entry chronologically. Include events, activities, interactions, thoughts, and feelings. Structure as morning → afternoon → evening if timeline is present. Capture both events and emotional responses."
            },
            "goals": {
                "title": "Goals & Planning",
                "instructions": "Extract goals, plans, and aspirations. Format with: Current situation, Desired outcomes, Action steps, Timeline (if mentioned), Motivation/Why. Make it actionable and inspiring."
            },
            "dream": {
                "title": "Dream Journal",
                "instructions": "Format as a dream journal entry. Preserve vivid details, emotions felt during the dream, symbols or recurring themes, and any immediate interpretations. Maintain the dreamlike flow while organizing for clarity."
            }
        }
        
        entry_config = type_instructions[entry_type]
        
        prompt = f"""Convert this voice note into a {entry_config['title']}.

Date: {today}, {time_now}

Voice note:
\"\"\"{transcript}\"\"\"

{entry_config['instructions']}

Format requirements:
- Start with date and time
- Keep authentic, personal voice
- Organize thoughts into readable paragraphs (3-5 sentences each)
- Preserve emotional content and tone
- Remove excessive filler words but keep conversational feel
- Add line breaks for readability
- Use first person throughout
- Keep it intimate and personal
- Format in Markdown

Output ONLY the journal entry."""

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
                        {
                            "role": "system",
                            "content": "You are a thoughtful journaling assistant. You help people format voice notes into meaningful journal entries while preserving their authentic voice, emotions, and personal style. You understand the therapeutic value of journaling and treat each entry with care and respect."
                        },
                        {
                            "role": "user",
                            "content": prompt
                        }
                    ],
                    "temperature": 0.7,
                    "max_tokens": 1500
                },
                timeout=60
            )
            
            if response.status_code == 200:
                entry = response.json()["choices"][0]["message"]["content"]
                
                word_count = len(entry.split())
                
                return f"""✅ **Journal Entry Created** ({entry_config['title']})

📅 **{today}**
📊 **~{word_count} words**

---

{entry}

---

### 💾 Save Options:

**Digital Journal:**
- Copy to journal app (Day One, Journey, etc.)
- Save to Obsidian/Notion
- Store in private folder

**Physical Journal:**
- Print and add to physical journal
- Type into paper journal using as template

**Cloud Storage:**
- Save to secure cloud folder
- Add to daily notes

### 🎨 Enhancement Ideas:

**Add tags:**
Ask: "Add relevant tags/themes to this entry"

**Expand:**
Ask: "Expand on the part about [topic]"

**Reflect deeper:**
Ask: "Help me reflect more deeply on [aspect]"

**Find patterns:**
Ask: "What themes or patterns do you notice?"

**Create follow-up:**
Ask: "Suggest journaling prompts based on this entry"

### 📊 Journal Types:

Current: **{entry_type.title()}**

Try different types:
- `general` - Everyday journaling
- `gratitude` - Focus on what you're thankful for
- `reflection` - Deep introspection and lessons
- `daily` - Chronological daily log
- `goals` - Planning and aspirations
- `dream` - Record dreams and symbols

**Example:**
```
voice_to_journal(
    transcript="[your voice note]",
    entry_type="gratitude"
)
```

### 🔐 Privacy Note:

Your journal entries are private. They're processed through GPT-5 for formatting only and not stored by OpenAI.

For maximum privacy:
- Use local AI models instead (see project docs)
- Encrypt your journal files
- Use secure storage locations
"""
            else:
                error_msg = response.text
                return f"""❌ **Error Creating Entry**

**Status Code:** {response.status_code}
**Details:** {error_msg}

**Troubleshooting:**
- Verify API key is configured
- Check GPT-5 access
- Ensure API credits available
"""
                
        except Exception as e:
            return f"❌ **Error:** {str(e)}\n\nCheck configuration and try again."


