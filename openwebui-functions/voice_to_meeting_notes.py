"""
title: Voice to Meeting Notes
author: open-webui
version: 1.0
description: Convert meeting transcript into structured notes using GPT-5
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

    def voice_to_meeting_notes(
        self,
        transcript: str,
        meeting_title: str = "Team Meeting",
        __user__: dict = {}
    ) -> str:
        """
        Convert meeting transcript into structured, actionable notes.
        
        :param transcript: The meeting recording transcript
        :param meeting_title: Title or topic of the meeting
        :return: Structured meeting notes with action items
        
        Example usage:
        voice_to_meeting_notes(
            transcript="We discussed the Q4 roadmap...",
            meeting_title="Q4 Planning Meeting"
        )
        """
        
        today = datetime.now().strftime("%A, %B %d, %Y at %I:%M %p")
        
        prompt = f"""Convert this meeting transcript into comprehensive, structured notes.

Meeting Title: {meeting_title}
Date: {today}

Transcript:
\"\"\"{transcript}\"\"\"

Create meeting notes with the following structure:

# {meeting_title}

**Date:** {today}
**Participants:** [Extract from transcript if mentioned]

## 📋 Meeting Overview
Brief 2-3 sentence summary of what was discussed

## 🗣️ Key Discussion Points
Organize main topics covered with bullet points:
- Use clear, concise language
- Group related topics together
- Include important context and rationale

## ✅ Decisions Made
List all decisions clearly:
- What was decided
- Why it was decided (if mentioned)
- Any conditions or caveats

## 📌 Action Items
Format as checklist with details:
- [ ] Task description
  - Owner: [Person responsible]
  - Due: [Date if mentioned, or "TBD"]
  - Priority: [High/Medium/Low if indicated]
  
## 🔄 Follow-up & Next Steps
- Upcoming meetings
- Pending decisions
- Items to revisit
- Next meeting date/time (if scheduled)

## 📝 Additional Notes
Any other relevant information, concerns raised, or context

---

**Output:** Format in clean Markdown. Be thorough but concise. Extract ALL action items clearly."""

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
                            "content": "You are an expert meeting facilitator and note-taker. You excel at converting meeting transcripts into clear, actionable, well-structured notes. You extract action items precisely and organize information logically."
                        },
                        {
                            "role": "user",
                            "content": prompt
                        }
                    ],
                    "temperature": 0.3,  # Lower temp for factual accuracy
                    "max_tokens": 2000
                },
                timeout=60
            )
            
            if response.status_code == 200:
                notes = response.json()["choices"][0]["message"]["content"]
                
                return f"""✅ **Meeting Notes Generated!**

---

{notes}

---

### 📋 What to Do Next:

**Share with team:**
1. Copy notes above
2. Send via email or Slack
3. Post to team documentation
4. Schedule follow-up if needed

**Track action items:**
1. Review the action items section
2. Want to create tasks in Vikunja?
   - Copy each action item
   - Use the `create_vikunja_tasks` function
   - OR paste action items and ask me to create tasks
3. Set calendar reminders for due dates
4. Follow up with assigned owners

**Save for reference:**
- Add to meeting minutes folder
- Link in project documentation
- Archive in knowledge base

### 💡 Need Changes?

Ask me to:
- "Add more detail about [topic]"
- "Clarify the action item about [task]"
- "Extract just the action items"
- "Format this for email"
- "Add a summary at the top"
- "Create Vikunja tasks from action items"

### 📊 Quick Actions:

**Extract just action items:**
Ask: "Show me just the action items as a list"

**Create tasks:**
Ask: "Create Vikunja tasks from these action items"

**Send summary email:**
Ask: "Format this as an email to send to the team"
"""
            else:
                error_msg = response.text
                return f"""❌ **Error Generating Notes**

**Status Code:** {response.status_code}

**Details:** {error_msg}

**Try:**
- Check API key configuration
- Verify GPT-5 access
- Ensure sufficient API credits
"""
                
        except Exception as e:
            return f"❌ **Error:** {str(e)}\n\nCheck API configuration and try again."


