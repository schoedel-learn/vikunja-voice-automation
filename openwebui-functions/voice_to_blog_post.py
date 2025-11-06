"""
title: Voice to Blog Post
author: open-webui
version: 1.0
description: Convert voice note transcript into polished blog post using GPT-5
"""

from pydantic import BaseModel, Field
from typing import Optional
import requests


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
        Convert voice note transcript into a polished blog post.
        
        :param transcript: The voice note transcript text
        :param tone: Blog tone - choose from: casual, professional, technical, friendly, inspirational
        :param length: Post length - choose from: short (300 words), medium (600 words), long (1000 words)
        :return: Formatted blog post in Markdown
        
        Example usage:
        voice_to_blog_post(
            transcript="Today I want to talk about AI and healthcare...",
            tone="professional",
            length="long"
        )
        """
        
        # Validate inputs
        valid_tones = ["casual", "professional", "technical", "friendly", "inspirational"]
        valid_lengths = ["short", "medium", "long"]
        
        if tone not in valid_tones:
            return f"❌ Invalid tone. Choose from: {', '.join(valid_tones)}"
            
        if length not in valid_lengths:
            return f"❌ Invalid length. Choose from: {', '.join(valid_lengths)}"
        
        # Define length targets
        length_map = {
            "short": "approximately 300-400 words",
            "medium": "approximately 600-700 words", 
            "long": "approximately 1000-1200 words"
        }
        
        target_length = length_map[length]
        
        # Create blog post prompt
        prompt = f"""Convert this voice note transcript into a polished, engaging blog post.

Voice note transcript:
\"\"\"{transcript}\"\"\"

Requirements:
- **Tone**: {tone}
- **Length**: {target_length}
- **Title**: Create an engaging, SEO-friendly title
- **Structure**: Use clear headings (## for H2, ### for H3)
- **Introduction**: Start with a hook that grabs attention
- **Body**: 
  - Use short paragraphs (2-3 sentences max)
  - Include bullet points for lists
  - Add subheadings for major sections
  - Make it scannable and easy to read
- **Conclusion**: End with a strong takeaway or call-to-action
- **Format**: Pure Markdown
- **Voice**: Convert rambling speech into polished prose
  - Remove filler words (um, uh, like)
  - Fix grammar and sentence structure
  - Keep the core message and insights
  - Maintain authenticity

Output ONLY the blog post in Markdown, starting with # Title."""

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
                            "content": f"You are an expert blog writer and editor. Your specialty is converting rambling voice notes into polished, engaging blog posts. You maintain the speaker's authentic voice while improving clarity and structure. You write in a {tone} tone."
                        },
                        {
                            "role": "user",
                            "content": prompt
                        }
                    ],
                    "temperature": 0.7,
                    "max_tokens": 2000
                },
                timeout=60
            )
            
            if response.status_code == 200:
                blog_post = response.json()["choices"][0]["message"]["content"]
                
                # Count approximate words
                word_count = len(blog_post.split())
                
                return f"""✅ **Blog Post Generated Successfully!**

📊 **Stats:** ~{word_count} words | {tone.title()} tone

---

{blog_post}

---

### 📝 Next Steps:

1. **Review & Edit**: Read through and make any adjustments
2. **Add Media**: Consider where to add images, videos, or graphics
3. **SEO**: Add meta description and keywords
4. **Publish**: Copy to your blog platform

### 💡 Want Changes?

Ask me to:
- "Make it longer/shorter"
- "Change the tone to [casual/professional/etc]"
- "Expand the section about [topic]"
- "Add more examples"
- "Make it more/less technical"
- "Rewrite the introduction"

### 📋 Copy Options:

**Markdown** (for most platforms):
- Copy the blog post above as-is

**HTML** (if needed):
- Ask: "Convert this to HTML"

**Plain text** (for email):
- Ask: "Remove the Markdown formatting"
"""
            else:
                error_msg = response.text
                return f"""❌ **Error Calling GPT-5 API**

**Status Code:** {response.status_code}

**Error Details:**
```
{error_msg}
```

**Troubleshooting:**
1. Check your OpenAI API key is valid
2. Verify you have GPT-5 access
3. Ensure you have API credits
4. Try again in a moment (might be rate limited)
"""
                
        except requests.exceptions.Timeout:
            return """❌ **Request Timed Out**

The API call took too long (>60 seconds).

**Try:**
1. Shorten your transcript
2. Try again (server might be busy)
3. Check your internet connection
"""
        except Exception as e:
            return f"""❌ **Unexpected Error**

**Error:** {str(e)}

**Troubleshooting:**
1. Check your OpenAI API key is configured
2. Verify network connectivity
3. Try a shorter transcript
4. Check the Open WebUI logs for details
"""


