# Contributing to Voice-to-Tasks Automation

First off, thank you for considering contributing to Voice-to-Tasks Automation! It's people like you that make this project a great tool for productivity enthusiasts everywhere.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Community](#community)

---

## 📜 Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

---

## 🤝 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find that you don't need to create one. When you are creating a bug report, please include as many details as possible:

**Bug Report Template:**

```
**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. See error

**Expected behavior**
A clear description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment:**
- OS: [e.g. Ubuntu 22.04]
- Docker Version: [e.g. 24.0.7]
- n8n Version: [e.g. 1.17.2]
- Node Version: [e.g. 20.x]

**Additional context**
Add any other context about the problem here.
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any similar features in other projects** (if applicable)

### Your First Code Contribution

Unsure where to begin? You can start by looking through these issues:

- `good-first-issue` - Issues that should only require a few lines of code
- `help-wanted` - Issues that may be more involved

### Pull Requests

1. Fork the repo and create your branch from `main`
2. If you've added code that should be tested, add tests
3. Ensure your code follows the existing style
4. Update documentation as needed
5. Write a clear commit message

---

## 🛠️ Development Setup

### Prerequisites

- Docker & Docker Compose
- Node.js 18+ and NPM
- Python 3.9+ (for Open WebUI functions)
- Git

### Local Setup

1. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR-USERNAME/vikunja-voice-automation.git
   cd vikunja-voice-automation
   ```

2. **Create environment file:**
   ```bash
   cp env.example .env
   # Edit .env with your test credentials
   ```

3. **Set up test environment:**
   ```bash
   # Install any dependencies
   npm install  # if applicable
   ```

4. **Run tests:**
   ```bash
   # Run your test suite
   npm test
   ```

---

## 🔄 Pull Request Process

1. **Update the README.md** with details of changes if applicable
2. **Update documentation** in the `/docs` folder
3. **Follow the PR template** provided
4. **Request review** from maintainers
5. **Address feedback** promptly and professionally
6. **Squash commits** before merging (if requested)

### PR Title Format

Use conventional commits format:

```
feat: add voice note batch processing
fix: resolve Vikunja API timeout issue
docs: update installation instructions
chore: update dependencies
```

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested locally
- [ ] Added/updated tests
- [ ] All tests pass

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No new warnings generated
```

---

## 💻 Coding Standards

### Python (Open WebUI Functions)

- Follow **PEP 8** style guide
- Use **type hints** for function parameters and return values
- Write **docstrings** for all functions and classes
- Keep functions **small and focused**

Example:
```python
def create_task(
    self,
    project_id: int,
    title: str,
    description: str = "",
    priority: int = 0
) -> str:
    """
    Create a new task in a Vikunja project.
    
    Args:
        project_id: The ID of the project
        title: Task title/summary
        description: Detailed task description (optional)
        priority: Priority level 0-5 (optional)
    
    Returns:
        JSON string with created task details or error
    """
    # Implementation
```

### JSON (n8n Workflows)

- Use **2 spaces** for indentation
- Keep workflows **well-organized** and **commented**
- Use **meaningful node names**
- Group related nodes visually

### Documentation (Markdown)

- Use **clear headings** and **proper hierarchy**
- Include **code examples** where helpful
- Add **screenshots** for UI-related docs
- Keep language **simple and accessible**

### Commit Messages

Follow the **Conventional Commits** specification:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

---

## 🏗️ Project Structure

```
vikunja-voice-automation/
├── docs/                    # Documentation
├── n8n/                     # n8n workflows
├── functions/               # Open WebUI functions
├── scripts/                 # Helper scripts
├── .github/                 # GitHub templates
│   ├── ISSUE_TEMPLATE/
│   └── PULL_REQUEST_TEMPLATE.md
├── env.example              # Environment template
├── .gitignore              # Git ignore rules
├── LICENSE                  # MIT License
├── README.md               # Main README
├── CONTRIBUTING.md         # This file
├── CODE_OF_CONDUCT.md      # Code of conduct
└── SECURITY.md             # Security policy
```

---

## 🌍 Community

### Getting Help

- **GitHub Discussions** - Ask questions and share ideas
- **GitHub Issues** - Report bugs and request features
- **Documentation** - Check the `/docs` folder

### Stay Updated

- **Watch the repository** for notifications
- **Star the project** to show support
- **Follow releases** for new versions

---

## 🎯 Areas We Need Help

### High Priority

- 🧪 **Testing** - Add automated tests
- 📝 **Documentation** - Improve setup guides
- 🐛 **Bug Fixes** - Address open issues
- 🎨 **UI/UX** - Improve Open WebUI functions

### Medium Priority

- 🌐 **Internationalization** - Add multi-language support
- 📱 **Mobile** - Build mobile app integration
- 🔐 **Security** - Security audits and improvements
- ⚡ **Performance** - Optimization and caching

### Nice to Have

- 🎤 **Voice Commands** - Direct voice input to Vikunja
- 🤖 **AI Models** - Support for more AI providers
- 📊 **Analytics** - Usage statistics and insights
- 🔌 **Integrations** - Connect with more tools

---

## ❓ Questions?

Don't hesitate to ask! We're here to help:

- Open a **GitHub Discussion** for general questions
- Create an **Issue** for specific problems
- Check existing **Documentation** first

---

## 🙏 Thank You!

Your contributions make this project better for everyone. We appreciate your time and effort!

**Happy coding!** 🎉

---

*This contributing guide is inspired by open source best practices and adapted for our project.*

