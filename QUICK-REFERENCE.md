# 🚀 AI Use Cases - Quick Reference

## ⚡ Unified CLI (Simplest!)

After installation, use these commands anywhere:

```bash
ai-use-case --init              # Setup current project
ai-use-case document            # Document AI session
ai-use-case sync                # Sync to hub
ai-use-case search <term>       # Search use cases
ai-use-case stats               # View statistics
ai-use-case --help              # Show all commands
```

## 🤖 For Claude Code Users

**Slash Commands** (use in Claude Code chat):
```
/document-session    Document your AI-assisted session
/setup-project       Setup current project
/sync-usecases       Manual sync to hub
/search-usecases     Search all use cases
/quick-start         Complete setup guide
```

## 💻 For GitHub Copilot / VS Code Users

**Keyboard Shortcuts:**
- `Ctrl+Alt+D` / `Cmd+Alt+D` - Document AI Session
- `Ctrl+Alt+S` / `Cmd+Alt+S` - Search Use Cases

**Command Palette** (`Ctrl/Cmd+Shift+P`):
- AI Use Cases: Document AI Session
- AI Use Cases: Setup Project for AI Use Cases
- AI Use Cases: Sync AI Use Cases to Hub
- AI Use Cases: Search AI Use Cases
- AI Use Cases: View Use Cases in Hub

**Copilot Chat:**
```
@workspace document my AI session
```

---

## 🆕 First-Time Setup

**One-command install:**
```bash
curl -fsSL https://raw.githubusercontent.com/james401/ai-use-case-hub-/main/install.sh | bash
```

**Or manual install:**
```bash
git clone https://github.com/james401/ai-use-case-hub-.git ~/Documents/ai-use-case-hub
cd ~/Documents/ai-use-case-hub
./install.sh
```

**Then setup your first project:**
```bash
cd /path/to/your/project
ai-use-case --init
```

Done! Now you can use `ai-use-case document` anytime.

---

## Essential Commands

### Setup New Project
```bash
ai-use-case --init
# Or for specific project:
ai-use-case --init /path/to/project
```

### Document AI Session
```bash
ai-use-case document
```

### Manual Sync
```bash
ai-use-case sync
# Or for specific project:
ai-use-case sync /path/to/project
```

### Search Use Cases
```bash
ai-use-case search authentication
ai-use-case search "react hooks"
```

### View Statistics
```bash
ai-use-case stats
```

## File Naming Convention
```
YYYY-MM-DD_TICKET-XXXXX_brief-description.md
```

Example:
```
2025-10-13_LSFB-63055_add-environment-parameter-message-flow.md
```

## Directory Structure
```
~/Documents/ai-use-cases/
├── by-project/[project-name]/     # CANONICAL - actual files stored here
├── by-date/[YYYY]/[MM]/          # VIEW - symlinks to by-project files
└── by-topic/[topic-slug]/        # VIEW - symlinks to by-project files
```

**💾 Storage:** Files stored once in `by-project/`, symlinks provide alternate views

## Quick Views

### View by Project (Canonical)
```bash
ls ~/Documents/ai-use-cases/by-project/document-handler-srv/
# Shows actual files
```

### View by Date (Symlinks)
```bash
ls -lh ~/Documents/ai-use-cases/by-date/2025/10/
# Shows symlinks -> by-project files
```

### View by Topic (Symlinks)
```bash
ls -lh ~/Documents/ai-use-cases/by-topic/
# Shows symlinks -> by-project files
```

### Count Disk Usage
```bash
du -sh ~/Documents/ai-use-cases/by-project/
# Shows actual disk usage (no duplication!)
```

### Recent Use Cases
```bash
find ~/Documents/ai-use-cases/by-date -name "*.md" -type f -printf '%T@ %p\n' | sort -rn | head -5 | cut -d' ' -f2-
```

## Bash Aliases (Optional)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# AI Use Cases shortcuts
alias aiuc-setup='~/Documents/ai-use-cases/setup-project.sh'
alias aiuc-sync='~/Documents/ai-use-cases/sync-ai-use-cases.sh'
alias aiuc-list='ls ~/Documents/ai-use-cases/by-project/'
alias aiuc-recent='find ~/Documents/ai-use-cases/by-date -name "*.md" -type f -printf "%T@ %p\n" | sort -rn | head -10 | cut -d" " -f2-'
alias aiuc-cd='cd ~/Documents/ai-use-cases'

# Quick open recent
alias aiuc-open='find ~/Documents/ai-use-cases/by-date -name "*.md" -type f -printf "%T@ %p\n" | sort -rn | head -1 | cut -d" " -f2- | xargs code'
```

After adding, run:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

Then use:
```bash
aiuc-setup          # Setup current project
aiuc-sync           # Sync current project
aiuc-list           # List all projects
aiuc-recent         # Show 10 most recent use cases
aiuc-cd             # Navigate to central repo
aiuc-open           # Open most recent use case in VS Code
```

## Troubleshooting

### Hook not working?
```bash
chmod +x .git/hooks/post-commit
```

### Manual sync not working?
```bash
bash -x ~/Documents/ai-use-cases/sync-ai-use-cases.sh
```

### Check what will be synced
```bash
find . -type d -name "ai-use-cases" -exec find {} -name "*.md" \;
```

## Creating a New Use Case

1. Navigate to your project
2. Create file in `docs/ai-use-cases/`
3. Use naming convention: `YYYY-MM-DD_TICKET-XXXXX_description.md`
4. Write your documentation
5. Commit with git - syncs automatically!

```bash
cd ~/Documents/medtrainer/document-handler-srv
vim docs/ai-use-cases/2025-10-14_PROJ-123_my-feature.md
git add docs/ai-use-cases/2025-10-14_PROJ-123_my-feature.md
git commit -m "docs: add AI use case for PROJ-123"
# Automatically syncs to central repository!
```

---

For full documentation, see [README.md](./README.md)
