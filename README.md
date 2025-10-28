# 🎤 Voice-to-Tasks Automation System

An AI-powered system that converts voice notes into organized project tasks automatically using Vikunja, n8n, OpenAI, and Open WebUI.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Status: In Development](https://img.shields.io/badge/Status-In%20Development-orange)](https://github.com)

---

## 🎯 Overview

**Transform rambling voice notes into structured tasks with zero manual work.**

This system uses AI to:
- 📱 Accept voice recordings via email
- 🎧 Transcribe audio using OpenAI Whisper
- 🤖 Extract multiple tasks using GPT-5
- 📊 Automatically categorize into appropriate projects
- ✅ Create tasks in Vikunja with proper context

---

## ✨ Features

- **AI-Powered Task Extraction**: GPT-5 understands context and intent from rambling speech
- **Multi-Task Support**: Extracts multiple distinct tasks from a single voice note
- **Smart Categorization**: Automatically assigns tasks to the correct projects
- **Email Integration**: Simple workflow - just email your voice note
- **Confirmation Notifications**: Get email confirmations when tasks are created
- **Self-Hosted**: Complete control over your data
- **Open Source Stack**: Built entirely with open-source tools

---

## 🏗️ Architecture

```
Voice Recording (Phone)
  ↓
Email with Audio Attachment
  ↓
n8n Automation Workflow
  ├─→ Whisper API (Transcription)
  ├─→ GPT-5 (Task Extraction)
  └─→ Vikunja API (Task Creation)
  ↓
Confirmation Email Sent
```

---

## 📦 Tech Stack

| Component | Purpose | Technology |
|-----------|---------|------------|
| **Task Management** | Project & task organization | [Vikunja](https://vikunja.io/) |
| **Automation** | Workflow orchestration | [n8n](https://n8n.io/) |
| **Transcription** | Voice-to-text conversion | OpenAI Whisper |
| **AI Processing** | Task extraction & categorization | OpenAI GPT-5 |
| **AI Interface** | Knowledge center & manual task creation | [Open WebUI](https://github.com/open-webui/open-webui) |
| **Email** | Voice note delivery | IMAP/SMTP |
| **Containerization** | Deployment | Docker & Docker Compose |

---

## 🚀 Current Status

### ✅ Completed
- [x] GPT-5 + Vikunja integration working
- [x] Open WebUI function for manual task creation
- [x] AI successfully parsing complex voice notes
- [x] Multi-task extraction from single recording
- [x] Automatic project matching
- [x] Vikunja API integration (PUT method)
- [x] n8n workflow designed

### 🚧 In Progress
- [ ] n8n workflow deployment and testing
- [ ] Email server configuration (Mailcow)
- [ ] End-to-end automation testing
- [ ] RunPod GPU integration for local models

### 📋 Planned
- [ ] Mobile app for direct recording
- [ ] Real-time transcription
- [ ] Multi-language support
- [ ] Voice commands for task queries
- [ ] Team collaboration features

---

## 📁 Project Structure

```
vikunja-voice-automation/
├── docs/                          # Documentation
│   ├── SETUP.md                  # Setup instructions
│   ├── CONFIGURATION.md          # Configuration guide
│   └── API.md                    # API documentation
├── n8n/                          # n8n workflows
│   └── voice-to-vikunja.json    # Main automation workflow
├── functions/                    # Open WebUI functions
│   └── vikunja_function.py      # Vikunja task manager function
├── scripts/                      # Helper scripts
│   └── setup/                   # Setup automation scripts
├── .env.example                  # Environment variables template
├── .gitignore                    # Git ignore rules
├── LICENSE                       # MIT License
└── README.md                     # This file
```

---

## 🔧 Prerequisites

- Docker & Docker Compose
- Vikunja instance (self-hosted or cloud)
- n8n instance (self-hosted or cloud)
- OpenAI API key (with GPT-5 access)
- Email server (IMAP/SMTP access)
- Open WebUI instance (optional, for manual task creation)

---

## 📚 Documentation

### Quick Start Guides
- [Setup Instructions](docs/SETUP.md) - Complete installation guide
- [Configuration Guide](docs/CONFIGURATION.md) - Credential setup
- [n8n Workflow Setup](docs/N8N_SETUP.md) - Workflow import & activation

### Advanced
- [Open WebUI Integration](docs/OPENWEBUI.md) - Manual task creation
- [RunPod GPU Setup](docs/RUNPOD.md) - Local model acceleration
- [API Reference](docs/API.md) - Vikunja API details

---

## 🎯 How It Works

### 1. Record Voice Note
Use any voice recording app on your phone (Google Recorder, Voice Memos, etc.)

### 2. Email the Recording
Send the audio file to your designated email address (e.g., `tasks@yourdomain.com`)

### 3. AI Processes
- **Whisper** transcribes your voice to text
- **GPT-5** analyzes the transcript and extracts individual tasks
- **GPT-5** matches each task to the appropriate Vikunja project

### 4. Tasks Created
Tasks automatically appear in Vikunja with:
- ✅ Proper titles
- ✅ Detailed descriptions
- ✅ Correct project assignment
- ✅ Priority levels

### 5. Get Confirmation
Receive an email confirming all tasks were created successfully

---

## 🧪 Testing Results

**Test Input** (rambling voice note):
> "Okay so I need to schedule a meeting with my doctoral advisor to discuss chapter three progress. Also I really need to renew my gym membership before it expires this week. Oh and I have to finish that website redesign proposal for the Miami client by Friday. And remind me to pick up groceries - milk, eggs, and bread."

**AI Output**:
- ✅ Task #33: "Meeting with doctoral advisor" → Doctoral Program project
- ✅ Task #34: "Renew gym membership" → Health project
- ✅ Task #35: "Website redesign proposal" → Active Work project
- ✅ Task #36: "Pick up groceries" → Inbox project

**Success Rate**: 100% (4/4 tasks created correctly)

---

## 🔐 Security & Privacy

- **Self-Hosted**: All data stays on your servers
- **No Vendor Lock-in**: Open-source stack
- **Encrypted Transit**: HTTPS/TLS for all communications
- **API Token Auth**: Secure API authentication
- **Environment Variables**: Sensitive data stored securely

---

## 💡 Use Cases

### Personal
- 📝 Capture ideas while driving
- 🏃 Record tasks while exercising
- 🛏️ Save thoughts before bed
- 🚶 Brainstorm during walks

### Professional
- 📞 Turn meeting notes into action items
- 🚗 Capture client requests on the go
- 🎤 Process voice memos from team
- 📊 Convert brainstorming sessions to tasks

### Academic
- 🎓 Track dissertation progress
- 📚 Manage research tasks
- ✍️ Organize writing projects
- 🔬 Plan experiments

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Vikunja](https://vikunja.io/) - Open-source task management
- [n8n](https://n8n.io/) - Workflow automation
- [Open WebUI](https://github.com/open-webui/open-webui) - AI interface
- [OpenAI](https://openai.com/) - Whisper & GPT-5

---

## 📧 Support

For questions, issues, or feature requests, please open an issue on GitHub.

---

## 🗺️ Roadmap

### v1.0 - Foundation (Current)
- Core voice-to-task pipeline
- n8n automation workflow
- GPT-5 task extraction

### v2.0 - Enhancement
- Mobile app integration
- Real-time processing
- Multi-language support

### v3.0 - Collaboration
- Team features
- Shared projects
- Voice commands

---

**Built with ❤️ for productivity enthusiasts**

*Status: Active Development | Last Updated: October 2025*

