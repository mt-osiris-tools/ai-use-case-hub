# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this documentation hub repository.

## Repository Purpose

This is the **AI Use Case Documentation Hub** - a centralized storage location for AI-assisted development workflow documentation across all your projects. It uses a symlink-based architecture to provide multiple organizational views without file duplication.

**Important**: This repository contains **documentation only**. The CLI tools for managing this hub are in a separate repository: [ai-use-case-cli](https://github.com/james401/ai-use-case-cli)

## Architecture Overview

The AI Use Case system consists of two repositories:

1. **[ai-use-case-cli](https://github.com/james401/ai-use-case-cli)** - Command-line tools for:
   - Setting up projects (`ai-use-case --init`)
   - Documenting sessions (`ai-use-case document`)
   - Syncing to hub (`ai-use-case sync`)
   - Searching use cases (`ai-use-case search`)

2. **ai-use-case-hub** (this repo) - Central documentation storage:
   - `by-project/` - Canonical storage (actual files)
   - `by-date/` - Symlink view organized by year/month
   - `by-topic/` - Symlink view organized by topic slug
   - Templates and examples

### Storage Model: Canonical + Views

**Critical principle**: Files are stored ONCE in `by-project/`. All other directories contain symlinks. This eliminates duplication while providing flexible browsing.

## Onboarding for New Users

**If you're setting up the AI Use Case system**, follow these steps:

### Step 1: Install the CLI Tools

```bash
curl -fsSL https://raw.githubusercontent.com/james401/ai-use-case-cli/main/install.sh | bash
```

See the [CLI documentation](https://github.com/james401/ai-use-case-cli) for details.

### Step 2: Clone This Documentation Hub

```bash
cd ~/Documents
git clone https://github.com/james401/ai-use-case-hub.git ai-use-case-hub
```

The CLI tools will automatically use this location (default: `~/Documents/ai-use-case-hub`).

### Step 3: (Optional) Configure Environment

Add to `~/.bashrc` or `~/.zshrc`:

```bash
export AI_USECASES_DIR="$HOME/Documents/ai-use-case-hub"
```

Then reload: `source ~/.bashrc` (or `source ~/.zshrc`)

### Step 4: Set Up Your First Project

```bash
cd /path/to/your-project
ai-use-case --init
```

You'll see:
- ✓ Created: docs/ai-use-cases/
- ✓ Git post-commit hook installed
- ✓ Sync complete!

**You're now ready to document AI sessions!**

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

The sync script (in CLI repo) uses regex to parse filenames and organize symlinks accordingly.

## Common Commands

All commands use the CLI tool. See [ai-use-case-cli](https://github.com/james401/ai-use-case-cli) for full documentation.

### Setting Up a New Project

```bash
# From within the project
ai-use-case --init

# Or specify a path
ai-use-case --init /path/to/project
```

**What this does:**
- Creates `docs/ai-use-cases/` in the project
- Installs post-commit hook
- Adds `.gitignore` patterns
- Runs initial sync to this hub

### Documenting AI Sessions

```bash
# Interactive documentation
ai-use-case document

# From VS Code
# Press Ctrl+Alt+D (or Cmd+Alt+D on Mac)
```

**What it does:**
- Collects git changes and session statistics
- Guides you through interactive prompts
- Generates documentation using TEMPLATE.md
- Saves to `docs/ai-use-cases/` with proper naming
- Optionally commits and syncs to this hub

### Manual Sync

```bash
# Sync current project
ai-use-case sync

# Sync specific project
ai-use-case sync /path/to/project
```

### Searching and Analyzing

```bash
# Search use cases
ai-use-case search authentication

# View statistics
ai-use-case stats

# List all projects
ai-use-case list
```

### Viewing Use Cases

```bash
# By project (canonical storage)
ls ~/Documents/ai-use-case-hub/by-project/my-project/

# By date (symlinks)
ls ~/Documents/ai-use-case-hub/by-date/2025/10/

# By topic (symlinks)
ls ~/Documents/ai-use-case-hub/by-topic/authentication/

# Recent use cases (last 10)
find ~/Documents/ai-use-case-hub/by-date -name "*.md" -type f -printf '%T@ %p\n' | \
  sort -rn | head -10 | cut -d' ' -f2-
```

### Analyzing Use Cases

```bash
# Count use cases per project
for dir in ~/Documents/ai-use-case-hub/by-project/*/; do
  echo "$(basename "$dir"): $(find "$dir" -name "*.md" | wc -l)"
done

# Search content
grep -r "Claude Code" ~/Documents/ai-use-case-hub/by-project --include="*.md"

# Disk usage (actual files only, no symlink duplication)
du -sh ~/Documents/ai-use-case-hub/by-project/
```

## Environment Variables

The CLI tools respect these optional environment variables:

```bash
export AI_USECASES_DIR="$HOME/Documents/ai-use-case-hub"
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

3. **Hub versioning** - This repository can be version controlled to track documentation evolution. The `.gitignore` is configured to track `by-project/` files but ignore `by-date/` and `by-topic/` symlinks (they're regenerated).

4. **Hub location** - The CLI tools support the `AI_USECASES_DIR` environment variable. If not set, they default to `$HOME/Documents/ai-use-case-hub`.

## Workflow for Creating New Use Cases

### Option 1: Automated (Recommended)
1. Complete your AI-assisted coding session
2. Run `ai-use-case document` (or use VS Code Ctrl+Alt+D)
3. Follow interactive prompts
4. CLI generates documentation, commits, and syncs to this hub

### Option 2: Manual
1. Navigate to your project
2. Create markdown file in `docs/ai-use-cases/` with proper naming
3. Document your AI-assisted work using the template
4. Commit the file with git
5. Post-commit hook automatically syncs to this hub

### Result (both options):
File appears in this hub at:
- `by-project/[project-name]/[filename].md` (actual file)
- `by-date/[year]/[month]/[project]_[filename].md` (symlink)
- `by-topic/[topic-slug]/[project]_[filename].md` (symlink)

## Hub Repository Structure

This repository contains:

- **by-project/**: Canonical storage - actual markdown files
- **by-date/**: Symlink view by year/month
- **by-topic/**: Symlink view by topic slug
- **docs/ai-use-cases/**: Example use cases
- **TEMPLATE.md**: Comprehensive use case template
- **README.md**: Hub documentation
- **QUICK-REFERENCE.md**: Quick command reference
- **CHANGELOG.md**: Version history
- **CLAUDE.md**: This file - guidance for Claude Code

**CLI tools** (in separate repo):
- ai-use-case (main CLI)
- setup-project.sh
- sync-ai-use-cases.sh
- document-ai-session.sh
- git-hooks/post-commit
- vscode-extension/

## Troubleshooting

### CLI Command Not Found

```bash
# Check if ~/.local/bin is in PATH
echo $PATH | grep ".local/bin"

# Add to shell profile if missing
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Files Not Syncing to Hub

```bash
# Check project is set up
ls -la /path/to/project/docs/ai-use-cases/

# Check git hook is executable
ls -la /path/to/project/.git/hooks/post-commit

# Test manual sync
ai-use-case sync /path/to/project
```

### Symlinks Broken

```bash
# Re-run sync to regenerate symlinks
ai-use-case sync /path/to/project

# Or regenerate all symlinks
for dir in ~/Documents/ai-use-case-hub/by-project/*/; do
  project=$(basename "$dir")
  find "$dir" -name "*.md" -type f
done
```

## Example Use Cases

See `by-project/` directories for examples:
- `ai-use-case-hub/2025-10-14_HUB-001_fix-color-encoding-in-cli-tools.md`
- `document-handler-srv/2025-10-13_LSFB-63055_add-environment-parameter-message-flow.md`

Each demonstrates:
- Comprehensive template usage
- Measurable outcomes and metrics
- Cost and time tracking
- Replicability patterns

## Related Resources

- **CLI Tools**: https://github.com/james401/ai-use-case-cli
- **Hub Repository**: https://github.com/james401/ai-use-case-hub (this repo)
- **Template**: `TEMPLATE.md` in this repository
- **Quick Reference**: `QUICK-REFERENCE.md` in this repository

## For Claude Code Users

When documenting AI sessions with Claude:

1. Focus on capturing the **why** and **how**, not just the **what**
2. Include specific prompts you used that worked well
3. Document any challenges and how Claude helped overcome them
4. Track token usage and time saved for ROI analysis
5. Note patterns that could be reused in future work

The documentation helps Claude understand your patterns and provide better assistance in future sessions.
