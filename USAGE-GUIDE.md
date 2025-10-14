# AI Session Documentor - Usage Guide

Quick guide to documenting your AI-assisted coding sessions.

## Quick Start

### 1. Setup Your Project (One-Time)

```bash
cd /path/to/your/project
~/Documents/ai-use-cases/setup-project.sh
```

### 2. Document a Session

**Option A: From Terminal**
```bash
~/Documents/ai-use-cases/document-ai-session.sh
```

**Option B: From VS Code**
- Press `Ctrl+Alt+D` (or `Cmd+Alt+D` on Mac)
- Or: Command Palette → "Document AI Session"
- Or: In Copilot Chat → `@workspace document my AI session`

### 3. Follow the Prompts

The script will ask for:
1. Date (defaults to today)
2. Ticket/Issue number (e.g., `PROJ-1234`)
3. Brief description (for filename)
4. AI tool used (Claude Code, Copilot, etc.)
5. Complexity (Low/Medium/High)
6. Time saved
7. TL;DR summary
8. Business context

### 4. Review and Commit

- Script generates a markdown file with TODO sections
- You can edit it before committing
- Commit triggers auto-sync to central repository

## Example Session

```bash
$ ~/Documents/ai-use-cases/document-ai-session.sh

=== AI Session Documentor ===
Project: my-awesome-project
Path: /home/user/projects/my-awesome-project

Collecting session data...

Session Summary:
  Branch: feature/user-auth
  Files changed: 8
  Recent commits (24h): 3
  Uncommitted changes: 0

Please provide session details:

Date (YYYY-MM-DD) [2025-10-14]:
Ticket/Issue (e.g., PROJ-1234): AUTH-123
Brief description (for filename): implement user authentication
AI Tool Used:
1) Claude Code (Sonnet 4.5)
2) GitHub Copilot
3) Claude Code + GitHub Copilot
4) Other
Select (1-4) [1]: 1

Complexity:
1) Low
2) Medium
3) High
Select (1-3) [2]: 2

Time saved vs manual approach (hours): 3

TL;DR Section:
What did AI help accomplish? (1-2 sentences): Implemented complete user authentication system with JWT tokens and password hashing
What was the result? (1-2 sentences): 8 files modified, all tests passing, ready for code review
Time spent on this task (e.g., '45 minutes'): 2 hours

Business Context:
Objective (what problem were you solving?): Enable secure user login for the application
Why was this work needed?: Required for multi-tenant feature launch

Generating documentation...
✓ Documentation created!
  Location: /home/user/projects/my-awesome-project/docs/ai-use-cases/2025-10-14_AUTH-123_implement-user-authentication.md

Open in editor? (y/N): y
Commit this documentation? (Y/n): y
✓ Documentation committed
📤 Post-commit hook will sync to central repository

=== Session Documentation Complete! ===

Next steps:
1. Fill in TODO sections in the document
2. Add code snippets and detailed technical insights
3. Update metrics and results

View: /home/user/projects/my-awesome-project/docs/ai-use-cases/2025-10-14_AUTH-123_implement-user-authentication.md
Central repo: ~/Documents/ai-use-cases/by-project/my-awesome-project/
```

## After Documentation

### Fill in TODO Sections

The generated document has several TODO markers for sections that need manual completion:

- `[Benefit 1], [Benefit 2], etc.` - Expected business benefits
- `[Step Name]` - Workflow step descriptions
- `[tokens/cost]` - Token usage if tracked
- `[language]` and code snippets
- Test results
- Links to PRs and resources

### View Your Documentation

**In Central Repository:**
```bash
# By project
ls ~/Documents/ai-use-cases/by-project/my-awesome-project/

# By date
ls ~/Documents/ai-use-cases/by-date/2025/10/

# By topic
ls ~/Documents/ai-use-cases/by-topic/
```

**In Your Project:**
```bash
ls docs/ai-use-cases/
```

## Tips

### For Claude Code Sessions

When using Claude Code, consider documenting:
- Specific Claude Code features used (TodoWrite, Read, Edit tools, etc.)
- Autonomous vs interactive coding
- Token usage estimates
- Number of tool calls
- Files read/modified by Claude

### For GitHub Copilot Sessions

When using Copilot, consider documenting:
- Inline suggestions accepted/rejected
- Chat conversations
- Slash commands used
- Code generation patterns

### For Hybrid Sessions

When using both tools together:
- Specify which tool was used for what
- Note how they complemented each other
- Document handoffs between tools

## VS Code Extension Setup

### Install Extension (Development Mode)

1. Clone and navigate:
   ```bash
   cd ~/Documents/ai-use-cases/vscode-extension
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Compile:
   ```bash
   npm run compile
   ```

4. Open in VS Code:
   ```bash
   code .
   ```

5. Press `F5` to launch Extension Development Host

### Configure Extension

Open VS Code Settings (`Cmd/Ctrl + ,`) and search for "AI Session":

- **Enabled**: Enable/disable the extension
- **Script Path**: Path to document-ai-session.sh (default: `~/Documents/ai-use-cases/document-ai-session.sh`)
- **Auto Open Editor**: Automatically open generated docs
- **Auto Commit**: Automatically commit documentation

## Troubleshooting

### "Project not set up for AI use cases"

Run the setup script:
```bash
~/Documents/ai-use-cases/setup-project.sh
```

### "Not a git repository"

Initialize git in your project:
```bash
git init
```

### Script not found

Check if the script exists and is executable:
```bash
ls -la ~/Documents/ai-use-cases/document-ai-session.sh
chmod +x ~/Documents/ai-use-cases/document-ai-session.sh
```

### VS Code extension not working

1. Verify script path in settings
2. Check if script is executable
3. Ensure project is set up with `setup-project.sh`
4. Check VS Code Output panel (View → Output → AI Session Documentor)

## Best Practices

1. **Document immediately** after completing a session while details are fresh
2. **Be specific** with metrics and time saved
3. **Include code snippets** of key patterns used
4. **Link to tickets/PRs** for traceability
5. **Fill in TODOs** before the next session
6. **Review monthly** to identify patterns and improvements

## Advanced Usage

### Custom Template

You can modify `TEMPLATE.md` to customize the generated documentation structure.

### Custom Script Path

Set environment variable:
```bash
export AI_USECASES_DIR="/custom/path/to/ai-use-cases"
```

### Batch Documentation

Document multiple sessions:
```bash
for project in ~/projects/*/; do
  if [ -d "$project/.git" ]; then
    ~/Documents/ai-use-cases/document-ai-session.sh "$project"
  fi
done
```

## Getting Help

- View full documentation: `~/Documents/ai-use-cases/README.md`
- Quick reference: `~/Documents/ai-use-cases/QUICK-REFERENCE.md`
- Claude Code guide: `~/Documents/ai-use-cases/CLAUDE.md`
- Report issues: https://github.com/james401/ai-use-case-hub-/issues
