# 🤖 AI Use Cases - Central Repository

A centralized repository for documenting AI-assisted development workflows across all projects.

## 📚 Documentation Guide

**Choose your path:**
- **New here?** → Start with [Getting Started](#-getting-started) below
- **Using Claude Code?** → See [Using with Claude Code](#-using-with-claude-code)
- **Using GitHub Copilot?** → See [Using with GitHub Copilot](#-using-with-github-copilot)
- **Need quick commands?** → See [QUICK-REFERENCE.md](./QUICK-REFERENCE.md)
- **AI assistant instructions?** → See [CLAUDE.md](./CLAUDE.md)

## 📋 Table of Contents

- [Getting Started](#-getting-started)
- [Using with Claude Code](#-using-with-claude-code)
- [Using with GitHub Copilot](#-using-with-github-copilot)
- [Quick Start](#-quick-start)
- [Directory Structure](#-directory-structure)
- [How It Works](#-how-it-works)
- [Configuration](#-configuration)
- [Best Practices](#-best-practices)
- [Troubleshooting](#-troubleshooting)

## 🚀 Getting Started

### Prerequisites

Before installing, ensure you have:

- **Git** (version 2.0+)
  ```bash
  git --version
  ```
- **Bash** (version 4.0+) - comes pre-installed on Linux/macOS
  ```bash
  bash --version
  ```
- **Basic tools:** `find`, `grep`, `ln` (standard on Unix-like systems)

**Optional:**
- **VS Code** (for extension features)
- **Node.js** (v16+, only if developing the VS Code extension)

### Installation

**Quick Install (Recommended):**

```bash
curl -fsSL https://raw.githubusercontent.com/james401/ai-use-case-hub/main/install.sh | bash
```

This will:
- Clone the repository to `~/Documents/ai-use-case-hub`
- Make all scripts executable
- Create `ai-use-case` command available globally
- Add to your PATH automatically
- Offer to configure your shell profile

**Manual Installation:**

```bash
git clone https://github.com/james401/ai-use-case-hub.git ~/Documents/ai-use-case-hub
cd ~/Documents/ai-use-case-hub
./install.sh
```

**Verify Installation:**

```bash
# Test the CLI tool
ai-use-case --version
ai-use-case --help

# Check installation
which ai-use-case
```

You should see the `ai-use-case` command available system-wide.

### First Project Setup

After installation, set up your first project:

```bash
# Navigate to your project
cd /path/to/your-project

# Setup with the CLI
ai-use-case --init

# You should see:
# ✓ Created: docs/ai-use-cases/
# ✓ Git post-commit hook installed
# ✓ Sync complete!
```

That's it! Your project is now ready to document AI sessions.

### Quick Test

Document a test session:

```bash
cd /path/to/your-project

# Run the interactive documentor
ai-use-case document

# Follow the prompts to create your first use case documentation
```

## 📁 Directory Structure

```
ai-use-cases/
├── by-project/               # CANONICAL STORAGE - files stored here
│   ├── document-handler-srv/
│   │   └── 2025-10-13_LSFB-63055_description.md
│   ├── api-gateway/
│   └── ...
├── by-date/                  # VIEW: Symlinks organized by year/month
│   └── 2025/
│       ├── 10/
│       │   └── project_filename.md -> ../../../by-project/project/filename.md
│       └── ...
├── by-topic/                 # VIEW: Symlinks organized by topic/feature
│   ├── add-environment-parameter/
│   │   └── project_filename.md -> ../../by-project/project/filename.md
│   └── ...
├── vscode-extension/         # VS Code extension for one-click documentation
│   ├── src/
│   ├── package.json
│   └── README.md
├── document-ai-session.sh    # Interactive AI session documentor
├── sync-ai-use-cases.sh      # Sync script (v2.0)
├── setup-project.sh          # Project setup script
├── git-hooks/
│   └── post-commit           # Auto-sync git hook
├── README.md                 # This file - main documentation
├── QUICK-REFERENCE.md        # Fast command lookup
├── CLAUDE.md                 # AI assistant instructions
└── TEMPLATE.md               # Documentation template
```

**💾 Storage Efficiency:** Files are stored once in `by-project/`. The `by-date/` and `by-topic/` directories contain symlinks for alternate views. This eliminates duplication while maintaining easy browsing.

## 🤖 Using with Claude Code

This repository is optimized for use with Claude Code! Custom slash commands make documentation effortless.

### Available Claude Code Commands

Once you're in a project with Claude Code, use these commands:

- **`/document-session`** - Document your completed AI session
  - Automatically captures git changes
  - Prompts for session details
  - Generates formatted documentation
  - Optionally commits and syncs

- **`/setup-project`** - Setup current project for use cases
  - Creates required directories
  - Installs git hooks
  - Performs initial sync

- **`/sync-usecases`** - Manually sync use cases to hub
  - Copies files to central repository
  - Creates symlinks by date and topic

- **`/search-usecases`** - Search across all use cases
  - Find by keyword, topic, or technology
  - Search file names or content
  - Show results from all projects

- **`/quick-start`** - Complete setup guide
  - First-time installation walkthrough
  - Project setup assistance
  - Documentation tutorial

### Typical Claude Code Workflow

1. Work on your code with Claude
2. Commit your changes
3. Type `/document-session` in Claude chat
4. Claude helps you fill in the documentation
5. Files automatically sync to central hub
6. Use `/search-usecases` to find similar past work

### Benefits for Claude Code Users

- **Context Retention**: Claude can read past use cases to learn your patterns
- **Automated Documentation**: Let Claude help write the documentation
- **Pattern Recognition**: Claude can identify reusable approaches
- **Knowledge Base**: Build a searchable library of AI-assisted work

## 💻 Using with GitHub Copilot

Works seamlessly with GitHub Copilot in VS Code!

### VS Code Extension

Install and use the AI Session Documentor extension:

**Available Commands** (Command Palette or keyboard shortcuts):
- `Ctrl+Alt+D` / `Cmd+Alt+D` - Document AI Session
- `Ctrl+Alt+S` / `Cmd+Alt+S` - Search Use Cases
- "AI Use Cases: Setup Project" - First-time setup
- "AI Use Cases: Sync" - Manual sync
- "AI Use Cases: View in Hub" - Open hub in file explorer

### Copilot Chat Integration

You can also use Copilot Chat:

```
@workspace document my AI session
```

Copilot will guide you through the documentation process.

### Typical Copilot Workflow

1. Code with Copilot inline suggestions and chat
2. Accept/reject suggestions as you work
3. Commit your changes
4. Press `Ctrl+Alt+D` to document
5. Fill in prompts (or let Copilot help!)
6. Specify which features you used (inline, chat, etc.)

### Benefits for Copilot Users

- **Track Effectiveness**: Document which suggestions worked best
- **Pattern Library**: Build a collection of effective prompts
- **Team Sharing**: Show teammates what Copilot patterns work
- **ROI Measurement**: Track time saved using Copilot

### Using Both Tools Together

Many developers use Claude Code for complex refactoring and Copilot for day-to-day coding:

1. Use Copilot for boilerplate and suggestions
2. Use Claude Code for architecture and complex changes
3. Document with `Ctrl+Alt+D` or `/document-session`
4. Select "Claude Code + GitHub Copilot" as the tool
5. Describe how each tool contributed
6. Build insights on when to use which tool

## 🚀 Quick Start

### Setup New Project

```bash
# Navigate to your project
cd /path/to/your-project

# Run setup script
~/Documents/ai-use-cases/setup-project.sh

# That's it! Your project is now configured for automatic AI use case syncing
```

### Manual Sync

```bash
# Sync current project
~/Documents/ai-use-cases/sync-ai-use-cases.sh

# Sync specific project
~/Documents/ai-use-cases/sync-ai-use-cases.sh /path/to/project
```

### Document AI Session (NEW)

Automatically generate documentation for your AI-assisted coding sessions:

**From Terminal:**
```bash
~/Documents/ai-use-cases/document-ai-session.sh
```

**From VS Code:**
- Press `Ctrl+Alt+D` (or `Cmd+Alt+D` on Mac)
- Command Palette → "Document AI Session"
- GitHub Copilot Chat → `@workspace document my AI session`

The script will:
- 🔍 Collect git changes and session statistics
- 💬 Guide you through interactive prompts
- 📝 Generate documentation using the template
- 💾 Save with proper naming convention
- 🚀 Optionally commit and auto-sync

## 📝 Use Case Document Format

Use cases should follow this naming convention:

```
YYYY-MM-DD_TICKET-XXXXX_brief-description.md
```

**Examples:**
- `2025-10-13_LSFB-63055_add-environment-parameter-message-flow.md`
- `2025-10-14_PROJ-1234_implement-user-authentication.md`
- `2025-10-15_FEAT-5678_refactor-database-schema.md`

## 🔄 How It Works

### Automatic Syncing

1. You create/edit an AI use case document in your project's `docs/ai-use-cases/` directory
2. You commit the changes with git
3. The post-commit hook automatically syncs the document to this central repository
4. The document is organized by project, date, and topic

### Organization Strategy

**By Project (Canonical Storage):** Files are stored here - edit/delete here
```bash
ls ~/Documents/ai-use-cases/by-project/document-handler-srv/
# Shows actual files (not symlinks)
```

**By Date (Symlink View):** Useful for chronological review or monthly reports
```bash
ls -lh ~/Documents/ai-use-cases/by-date/2025/10/
# Shows symlinks pointing to by-project/ files
```

**By Topic (Symlink View):** Useful for finding similar use cases across projects
```bash
ls -lh ~/Documents/ai-use-cases/by-topic/authentication/
# Shows symlinks pointing to by-project/ files
```

**💡 Note:** When you open a symlinked file, you're reading the original. Changes made through symlinks automatically update the canonical file.

## 🛠️ Project Setup Details

When you run `setup-project.sh`, it:

1. ✅ Creates `docs/ai-use-cases/` directory in your project
2. ✅ Installs git post-commit hook for auto-syncing
3. ✅ Adds ignore patterns to `.gitignore` for draft files
4. ✅ Performs initial sync of existing use cases
5. ✅ Creates README in the project's use cases directory

## 📋 Use Case Template

Create your use cases with this structure:

```markdown
# 🎯 Claude Code: [Brief Title]

**Date:** YYYY-MM-DD
**Repository/Project:** project-name
**Ticket:** [TICKET-XXXXX](link-to-ticket)
**Agent Used:** Claude Code (Sonnet 4.5)
**Complexity:** Low/Medium/High
**Time Saved:** X hours vs manual approach

## 📄 TL;DR
Brief summary of what was accomplished

## 🏢 Business Context
Why this work was needed

## 🔄 Workflow Steps
Step-by-step breakdown

## 🛠️ Technical Details
Tools, technologies, patterns used

## 📊 Results & Impact
Measurable outcomes

## 💡 Key Learnings
What worked well, what to improve

## 🎯 Best Practices Identified
Patterns to replicate

## 🔄 Replicability Framework
How to apply this to other projects
```

## 🔧 Configuration

### Environment Variables

You can customize locations by setting these environment variables:

```bash
# In your ~/.bashrc or ~/.zshrc
export AI_USECASES_DIR="$HOME/Documents/ai-use-cases"
export AI_USECASES_SYNC_SCRIPT="$AI_USECASES_DIR/sync-ai-use-cases.sh"
```

### Disable Auto-Sync for a Project

To disable automatic syncing for a specific project:

```bash
cd /path/to/project
rm .git/hooks/post-commit
# Or comment out the AI use cases section in the hook
```

## 📊 Analyzing Use Cases

### View All Use Cases by Project

```bash
find ~/Documents/ai-use-cases/by-project -name "*.md" -type f | sort
```

### Count Use Cases per Project

```bash
for dir in ~/Documents/ai-use-cases/by-project/*/; do
    echo "$(basename "$dir"): $(find "$dir" -name "*.md" | wc -l)"
done
```

### Find Use Cases by Topic

```bash
# Find all authentication-related use cases
find ~/Documents/ai-use-cases/by-topic -name "*authentication*" -type d
```

### View Recent Use Cases

```bash
# Last 10 use cases
find ~/Documents/ai-use-cases/by-date -name "*.md" -type f -printf '%T@ %p\n' | \
    sort -rn | head -10 | cut -d' ' -f2-
```

## 🤝 Multi-Project Workflow

### Setup Multiple Projects

```bash
# Setup all your projects at once
for project in ~/Documents/projects/*/; do
    if [ -d "$project/.git" ]; then
        ~/Documents/ai-use-cases/setup-project.sh "$project"
    fi
done
```

### Sync All Projects

```bash
# Sync all projects manually
for project in ~/Documents/projects/*/; do
    if [ -d "$project/.git" ]; then
        ~/Documents/ai-use-cases/sync-ai-use-cases.sh "$project"
    fi
done
```

## 📈 Reporting

### Generate Monthly Report

```bash
# List all use cases from October 2025
find ~/Documents/ai-use-cases/by-date/2025/10 -name "*.md" -type f | \
    while read file; do
        echo "## $(basename "$file")"
        echo ""
        grep "^## 📄 TL;DR" -A 5 "$file" || true
        echo ""
    done > monthly-report-2025-10.md
```

## 🎯 Best Practices

1. **Document Immediately:** Create use case documents right after completing AI-assisted work while details are fresh

2. **Be Specific:** Include ticket numbers, exact commands used, and measurable outcomes

3. **Include Context:** Future you (and others) will need to understand why decisions were made

4. **Track Costs:** Document token usage and time saved for ROI analysis

5. **Share Learnings:** Use the by-topic organization to share patterns across teams

## 🐛 Troubleshooting

### Hook Not Running

```bash
# Check if hook is executable
ls -la /path/to/project/.git/hooks/post-commit

# Make it executable if needed
chmod +x /path/to/project/.git/hooks/post-commit
```

### Sync Script Fails

```bash
# Run with bash -x for debugging
bash -x ~/Documents/ai-use-cases/sync-ai-use-cases.sh /path/to/project
```

### Files Not Syncing

```bash
# Check if files match the pattern
find /path/to/project -type d -name "ai-use-cases"
find /path/to/project/docs/ai-use-cases -name "*.md"
```

## 📚 Additional Resources

- Use case template: See any existing use case for reference
- Git hooks documentation: https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
- Claude Code documentation: https://docs.claude.com/claude-code

## 🔐 Privacy & Security

- **Local Only:** All files are stored locally on your machine
- **No Cloud Sync:** This system does not sync to any cloud service by default
- **Sensitive Data:** Be careful not to include API keys, passwords, or sensitive data in use cases
- **Git Commits:** Use cases in project repos will be committed to version control

If you want to share use cases across team members, consider:
- Setting up a shared network drive for the central repository
- Using git to version control the central repository
- Excluding sensitive projects from auto-sync

---

**Created:** 2025-10-14
**Last Updated:** 2025-10-14
**Version:** 2.1.0 (Added interactive AI session documentor + VS Code extension)
