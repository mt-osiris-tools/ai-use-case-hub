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

**Step 1: Install CLI Tools**
```bash
curl -fsSL https://raw.githubusercontent.com/james401/ai-use-case-cli/main/install.sh | bash
```

**Step 2: Clone Documentation Hub (Optional)**
```bash
cd ~/Documents
git clone https://github.com/james401/ai-use-case-hub.git ai-use-case-hub
```

**Step 3: Setup Your First Project**
```bash
cd /path/to/your-project
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

### List Projects
```bash
ai-use-case list
```

### View Hub Location
```bash
ai-use-case view
```

## File Naming Convention
```
YYYY-MM-DD_TICKET-XXXXX_brief-description.md
```

Example:
```
2025-10-14_PROJ-1234_implement-user-authentication.md
```

## Directory Structure
```
~/Documents/ai-use-case-hub/
├── by-project/[project-name]/     # CANONICAL - actual files stored here
├── by-date/[YYYY]/[MM]/          # VIEW - symlinks to by-project files
└── by-topic/[topic-slug]/        # VIEW - symlinks to by-project files
```

**💾 Storage:** Files stored once in `by-project/`, symlinks provide alternate views

## Quick Views

### View by Project (Canonical)
```bash
ls ~/Documents/ai-use-case-hub/by-project/my-project/
# Shows actual files
```

### View by Date (Symlinks)
```bash
ls -lh ~/Documents/ai-use-case-hub/by-date/2025/10/
# Shows symlinks -> by-project files
```

### View by Topic (Symlinks)
```bash
ls -lh ~/Documents/ai-use-case-hub/by-topic/authentication/
# Shows symlinks -> by-project files
```

### Count Disk Usage
```bash
du -sh ~/Documents/ai-use-case-hub/by-project/
# Shows actual disk usage (no duplication!)
```

### Recent Use Cases
```bash
find ~/Documents/ai-use-case-hub/by-date -name "*.md" -type f -printf '%T@ %p\n' | sort -rn | head -5 | cut -d' ' -f2-
```

## Bash Aliases (Optional)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# AI Use Cases shortcuts (using CLI)
alias aiuc='ai-use-case'
alias aiuc-doc='ai-use-case document'
alias aiuc-sync='ai-use-case sync'
alias aiuc-search='ai-use-case search'
alias aiuc-stats='ai-use-case stats'
alias aiuc-list='ai-use-case list'

# Hub browsing
alias aiuc-cd='cd ~/Documents/ai-use-case-hub'
alias aiuc-proj='ls ~/Documents/ai-use-case-hub/by-project/'
alias aiuc-recent='find ~/Documents/ai-use-case-hub/by-date -name "*.md" -type f -printf "%T@ %p\n" | sort -rn | head -10 | cut -d" " -f2-'
alias aiuc-open='find ~/Documents/ai-use-case-hub/by-date -name "*.md" -type f -printf "%T@ %p\n" | sort -rn | head -1 | cut -d" " -f2- | xargs code'
```

After adding, run:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

Then use:
```bash
aiuc document       # Document AI session
aiuc search auth    # Search for auth
aiuc stats          # View statistics
aiuc-proj           # List all projects
aiuc-recent         # Show 10 most recent use cases
aiuc-cd             # Navigate to hub
aiuc-open           # Open most recent use case in VS Code
```

## Troubleshooting

### CLI Command Not Found
```bash
# Check if ~/.local/bin is in PATH
echo $PATH | grep ".local/bin"

# Add to shell profile if missing
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Hook Not Working?
```bash
# Check if executable
ls -la .git/hooks/post-commit

# Make executable
chmod +x .git/hooks/post-commit
```

### Files Not Syncing?
```bash
# Test manual sync
ai-use-case sync

# Check project setup
ls -la docs/ai-use-cases/

# Verify naming convention
find docs/ai-use-cases -name "*.md"
```

### View Sync Status
```bash
# Check what will be synced
find . -type d -name "ai-use-cases" -exec find {} -name "*.md" \;
```

## Creating a New Use Case

### Option 1: Interactive (Recommended)
```bash
cd /path/to/your-project
ai-use-case document
# Follow the prompts - generates documentation automatically
```

### Option 2: Manual
1. Navigate to your project
2. Create file in `docs/ai-use-cases/`
3. Use naming convention: `YYYY-MM-DD_TICKET-XXXXX_description.md`
4. Write your documentation (use TEMPLATE.md as guide)
5. Commit with git - syncs automatically!

```bash
cd /path/to/your-project
vim docs/ai-use-cases/2025-10-14_PROJ-123_my-feature.md
git add docs/ai-use-cases/2025-10-14_PROJ-123_my-feature.md
git commit -m "docs: add AI use case for PROJ-123"
# Automatically syncs to hub!
```

## Environment Variables

```bash
# Set custom hub location (optional)
export AI_USECASES_DIR="$HOME/Documents/ai-use-case-hub"

# Add to PATH (if CLI not found)
export PATH="$HOME/.local/bin:$PATH"
```

Add to `~/.bashrc` or `~/.zshrc` and reload with `source ~/.bashrc`

## Related Resources

- **Full Documentation**: [README.md](./README.md)
- **Template**: [TEMPLATE.md](./TEMPLATE.md)
- **Claude Code Instructions**: [CLAUDE.md](./CLAUDE.md)
- **CLI Repository**: https://github.com/james401/ai-use-case-cli
- **Hub Repository**: https://github.com/james401/ai-use-case-hub

---

**Version**: 2.1.0 (Separated CLI and Hub repositories)
**Last Updated**: 2025-10-14
