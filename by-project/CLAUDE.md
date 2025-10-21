# CLAUDE.md

This file provides guidance to Claude Code (claude.com/code) when working with code in this repository.

## Repository Purpose

This is a **centralized documentation repository** for tracking AI-assisted development workflows across multiple software projects. It is NOT a code repository - it's a knowledge management system that uses a symlink-based architecture for efficient storage and multiple view patterns.

## Onboarding for New Developers

**If this repository is not yet installed on your machine**, follow these steps:

### Step 1: Clone the Repository

```bash
cd ~/Documents
git clone https://github.com/james401/ai-use-case-hub-.git ai-use-cases
cd ai-use-cases
```

### Step 2: Make Scripts Executable

```bash
chmod +x setup-project.sh sync-ai-use-cases.sh document-ai-session.sh
```

### Step 3: Verify Installation

```bash
ls -l *.sh
# Should show three executable scripts with -rwxr-xr-x permissions
```

### Step 4: (Optional) Configure Environment

Add to `~/.bashrc` or `~/.zshrc` for easier access:

```bash
export AI_USECASES_DIR="$HOME/Documents/ai-use-cases"
export PATH="$AI_USECASES_DIR:$PATH"
```

Then reload: `source ~/.bashrc` (or `source ~/.zshrc`)

### Step 5: Set Up Your First Project

```bash
cd /path/to/your/project
~/Documents/ai-use-cases/setup-project.sh
```

You'll see:
- ✓ Created: docs/ai-use-cases/
- ✓ Git post-commit hook installed
- ✓ Sync complete!

**You're now ready to document AI sessions!**

## Architecture Overview

### Storage Model: Canonical + Views

The repository uses a **single-source-of-truth with symlinked views** architecture:

- **`by-project/`**: Canonical storage - all actual markdown files live here
- **`by-date/`**: View layer - symlinks organized by YYYY/MM/
- **`by-topic/`**: View layer - symlinks organized by topic slug

**Critical principle**: Files are stored ONCE in `by-project/`. All other directories contain symlinks. This eliminates duplication while providing flexible browsing.

### Automation System

Projects are configured to auto-sync their AI use case documentation using:

1. **`setup-project.sh`**: One-time setup for a project repository
   - Creates `docs/ai-use-cases/` directory in target project
   - Installs git post-commit hook
   - Adds `.gitignore` patterns for draft files
   - Performs initial sync

2. **`sync-ai-use-cases.sh`**: Syncs documents from project to central repo
   - Copies files from project's `docs/ai-use-cases/` to `by-project/[project-name]/`
   - Creates symlinks in `by-date/` based on YYYY-MM-DD prefix in filename
   - Creates symlinks in `by-topic/` based on topic slug in filename
   - Idempotent - safe to run multiple times

3. **`git-hooks/post-commit`**: Installed in each project's `.git/hooks/`
   - Detects when markdown files in `ai-use-cases/` directories are committed
   - Automatically triggers sync script
   - Non-blocking - sync failures don't prevent commits

4. **`document-ai-session.sh`**: Interactive AI session documentor (NEW)
   - Guides you through documenting an AI-assisted coding session
   - Captures git changes, file modifications, timestamps
   - Auto-populates TEMPLATE.md with session data
   - Can be triggered from shell or VS Code extension
   - Integrates with existing sync workflow

5. **VS Code Extension**: `vscode-extension/` (NEW)
   - One-click documentation from VS Code
   - Triggered via Command Palette or keyboard shortcut (Ctrl+Alt+D)
   - Can be invoked from GitHub Copilot chat: `@workspace document my AI session`
   - Wraps the document-ai-session.sh script

## File Naming Convention

All use case documents MUST follow this pattern:
```
YYYY-MM-DD_TICKET-XXXXX_brief-description.md
```

**Examples:**
- `2025-10-13_LSFB-63055_add-environment-parameter-message-flow.md`
- `2025-10-14_PROJ-1234_implement-user-authentication.md`

**Parsing logic:**
- Date extraction: `^([0-9]{4})-([0-9]{2})-([0-9]{2})`
- Ticket and topic: `_([A-Z]+-[0-9]+)_(.+)\.md$`

The sync script uses regex to parse filenames and organize symlinks accordingly.

## Common Commands

### Setting Up a New Project

```bash
# From within the project you want to configure
~/Documents/ai-use-cases/setup-project.sh

# Or specify a path
~/Documents/ai-use-cases/setup-project.sh /path/to/project
```

**What this does:**
- Creates `docs/ai-use-cases/` in the project
- Installs post-commit hook
- Adds `.gitignore` patterns
- Runs initial sync

### Manual Sync

```bash
# Sync current directory
~/Documents/ai-use-cases/sync-ai-use-cases.sh

# Sync specific project
~/Documents/ai-use-cases/sync-ai-use-cases.sh /path/to/project
```

### Documenting AI Sessions (NEW)

**From Shell:**
```bash
# Interactive session documentor
~/Documents/ai-use-cases/document-ai-session.sh

# Or for specific project
~/Documents/ai-use-cases/document-ai-session.sh /path/to/project
```

**From VS Code:**
- Command Palette: `AI Session: Document AI Session`
- Keyboard: `Ctrl+Alt+D` (or `Cmd+Alt+D` on Mac)
- Copilot Chat: `@workspace document my AI session`

**What it does:**
- Collects git changes and session statistics
- Guides you through interactive prompts
- Generates documentation using TEMPLATE.md
- Saves to `docs/ai-use-cases/` with proper naming
- Optionally commits and syncs automatically

### Viewing Use Cases

```bash
# By project (canonical storage)
ls ~/Documents/ai-use-cases/by-project/document-handler-srv/

# By date (symlinks)
ls ~/Documents/ai-use-cases/by-date/2025/10/

# By topic (symlinks)
ls ~/Documents/ai-use-cases/by-topic/

# Recent use cases (last 10)
find ~/Documents/ai-use-cases/by-date -name "*.md" -type f -printf '%T@ %p\n' | \
  sort -rn | head -10 | cut -d' ' -f2-
```

### Analyzing Use Cases

```bash
# Count use cases per project
for dir in ~/Documents/ai-use-cases/by-project/*/; do
  echo "$(basename "$dir"): $(find "$dir" -name "*.md" | wc -l)"
done

# Disk usage (actual files only, no symlink duplication)
du -sh ~/Documents/ai-use-cases/by-project/
```

## Environment Variables

The scripts respect these optional environment variables:

```bash
export AI_USECASES_DIR="$HOME/Documents/ai-use-cases"
export AI_USECASES_SYNC_SCRIPT="$AI_USECASES_DIR/sync-ai-use-cases.sh"
```

## Document Template

Use cases should follow the comprehensive template in `TEMPLATE.md`, which includes:

- Business context and objectives
- Step-by-step workflow with time tracking
- Technical details including tools and token usage
- Cost efficiency analysis
- Results and success metrics
- Key learnings and best practices
- Replicability framework
- Implementation summary with file lists

The template emphasizes measurable outcomes, cost analysis, and knowledge transfer.

## Important Constraints

1. **Never modify files in `by-date/` or `by-topic/`** - these are symlinks. Always edit files in `by-project/` or the original project location.

2. **Respect the naming convention** - the sync script regex depends on it:
   - Must start with YYYY-MM-DD
   - Must include TICKET-XXXXX format
   - Must have descriptive slug after ticket

3. **No git repository** - This directory is NOT initialized as a git repository. It's designed for local-only storage. Use cases are versioned in their original project repositories.

4. **Script paths are absolute** - The hooks and scripts use absolute paths (e.g., `$HOME/Documents/ai-use-cases`). If this directory moves, projects need to be re-configured.

## Workflow for Creating New Use Cases

**Option 1: Automated (Recommended)**
1. Complete your AI-assisted coding session
2. Run `~/Documents/ai-use-cases/document-ai-session.sh` (or use VS Code command)
3. Follow interactive prompts
4. Script generates documentation, commits, and syncs automatically

**Option 2: Manual**
1. Navigate to your project
2. Create markdown file in `docs/ai-use-cases/` with proper naming
3. Document your AI-assisted work using the template
4. Commit the file with git
5. Post-commit hook automatically syncs to central repository

**Result (both options):**
File appears in:
- `by-project/[project-name]/[filename].md` (actual file)
- `by-date/[year]/[month]/[project]_[filename].md` (symlink)
- `by-topic/[topic-slug]/[project]_[filename].md` (symlink)

## Key Files

- **TEMPLATE.md**: Comprehensive use case template with all sections
- **README.md**: Full documentation for the system
- **QUICK-REFERENCE.md**: Condensed command reference
- **CHANGELOG.md**: Version history (v2.0 introduced symlink architecture)
- **setup-project.sh**: Project configuration script
- **sync-ai-use-cases.sh**: Synchronization script (v2.0)
- **document-ai-session.sh**: Interactive AI session documentor (NEW)
- **git-hooks/post-commit**: Hook template for auto-sync
- **vscode-extension/**: VS Code extension for one-click documentation (NEW)

## Troubleshooting

### Hook not executing
```bash
# Check if executable
ls -la /path/to/project/.git/hooks/post-commit

# Make executable
chmod +x /path/to/project/.git/hooks/post-commit
```

### Sync failing
```bash
# Debug mode
bash -x ~/Documents/ai-use-cases/sync-ai-use-cases.sh /path/to/project
```

### Files not syncing
```bash
# Verify naming pattern
find /path/to/project -name "*.md" | grep ai-use-cases

# Check for correct directory structure
find /path/to/project -type d -name "ai-use-cases"
```

## Example Use Case

See `by-project/document-handler-srv/2025-10-13_LSFB-63055_add-environment-parameter-message-flow.md` for a comprehensive example demonstrating:
- Systematic refactoring across 15 files
- Integration with Jira via Atlassian MCP
- Detailed token usage and cost analysis (~106k tokens, $2.12)
- Time savings quantification (45 min vs 3-4 hours manual)
- Test-driven validation (43/43 tests passing)
- Structured commit history (7 commits, 1 per Jira issue)
