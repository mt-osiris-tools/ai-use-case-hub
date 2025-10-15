# Quick Start - Setup AI Use Cases Hub

You are helping the user get started with the AI Use Cases Hub for the first time.

## Your Task

Guide the user through the complete setup process, from installation to documenting their first session.

## Steps

### 1. Check if Hub is Already Installed

```bash
ls -la ~/Documents/ai-use-case-hub 2>/dev/null && echo "✅ Hub installed" || echo "❌ Hub not found"
```

### 2. If Not Installed, Clone the Repository

```bash
cd ~/Documents
git clone https://github.com/james401/ai-use-case-hub-.git ai-use-case-hub
cd ai-use-case-hub
```

### 3. Make Scripts Executable

```bash
chmod +x setup-project.sh sync-ai-use-cases.sh document-ai-session.sh
ls -la *.sh | grep "rwx"
```

### 4. Verify Installation

```bash
# Test help flags
./setup-project.sh --help
./document-ai-session.sh --help

# Check directory structure
ls -la
```

### 5. Setup Current Project

If the user is in a project directory:

```bash
# Verify we're in a git repo
git rev-parse --show-toplevel

# Run setup
~/Documents/ai-use-case-hub/setup-project.sh
```

### 6. Explain What Was Set Up

Tell the user:
- ✅ `docs/ai-use-cases/` directory created in their project
- ✅ Git post-commit hook installed for auto-syncing
- ✅ `.gitignore` patterns added for draft files
- ✅ Central hub ready at `~/Documents/ai-use-case-hub/`

### 7. Show Available Commands

For Claude Code:
- `/document-session` - Document an AI session
- `/setup-project` - Setup another project
- `/sync-usecases` - Manual sync
- `/search-usecases` - Search past use cases

For VS Code:
- `Ctrl+Alt+D` / `Cmd+Alt+D` - Document session
- Command Palette → "AI Use Cases" commands
- GitHub Copilot Chat → `@workspace document my AI session`

### 8. Suggest First Documentation

Offer to help them document:
- Their current work session
- A recent completed task
- A test session to learn the workflow

## Key Points to Emphasize

1. **Three Storage Views:**
   - `by-project/` - Actual files (canonical)
   - `by-date/` - Symlinks organized by date
   - `by-topic/` - Symlinks organized by topic

2. **Automatic Syncing:**
   - Happens on every git commit
   - Files copied to central hub
   - Symlinks created automatically

3. **Documentation Format:**
   - Filename: `YYYY-MM-DD_TICKET-XXXXX_description.md`
   - Template-based content
   - Captures time saved, tools used, results

4. **AI Tool Integration:**
   - Works with Claude Code
   - Works with GitHub Copilot
   - Works with both together
   - Documents which tool was used

## Troubleshooting Common Issues

### Not a git repository
```bash
cd /path/to/project
git init
git add .
git commit -m "Initial commit"
```

### Scripts not executable
```bash
chmod +x ~/Documents/ai-use-case-hub/*.sh
```

### VS Code extension not working
- Check Settings → AI Session Documentor
- Verify hubPath: `~/Documents/ai-use-case-hub`
- Reload VS Code window

## Next Steps

After setup, suggest:
1. Document current session if they just finished work
2. Review the template: `~/Documents/ai-use-case-hub/TEMPLATE.md`
3. Browse documentation: `README.md`, `QUICK-REFERENCE.md`
4. Set up additional projects: `/setup-project` in each repo
5. Configure VS Code extension if they use it

## Success Criteria

User should have:
- ✅ Hub cloned and scripts executable
- ✅ Current project set up (if applicable)
- ✅ Understanding of how syncing works
- ✅ Knowledge of how to document future sessions
- ✅ Awareness of Claude Code slash commands
- ✅ Awareness of VS Code extension commands
