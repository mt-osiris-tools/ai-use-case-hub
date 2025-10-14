# 🚀 AI Use Cases - Quick Reference

## Essential Commands

### Setup New Project
```bash
~/Documents/ai-use-cases/setup-project.sh
# Or for specific project:
~/Documents/ai-use-cases/setup-project.sh /path/to/project
```

### Manual Sync
```bash
~/Documents/ai-use-cases/sync-ai-use-cases.sh
# Or for specific project:
~/Documents/ai-use-cases/sync-ai-use-cases.sh /path/to/project
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
