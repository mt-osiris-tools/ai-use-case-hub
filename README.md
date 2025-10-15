# 🤖 AI Use Cases - Central Repository

A centralized repository for documenting AI-assisted development workflows across all projects.

## 📋 Table of Contents

- [Getting Started](#-getting-started)
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

#### 1. Clone the Repository

```bash
# Clone to your home directory (recommended location)
cd ~/Documents
git clone https://github.com/james401/ai-use-case-hub-.git ai-use-cases

# Or clone to a custom location
git clone https://github.com/james401/ai-use-case-hub-.git /path/to/custom/location
```

#### 2. Make Scripts Executable

```bash
cd ~/Documents/ai-use-cases
chmod +x setup-project.sh
chmod +x sync-ai-use-cases.sh
chmod +x document-ai-session.sh
```

#### 3. (Optional) Add to PATH

For easier access from anywhere, add to your shell profile:

```bash
# For bash users - add to ~/.bashrc
echo 'export AI_USECASES_DIR="$HOME/Documents/ai-use-cases"' >> ~/.bashrc
echo 'export PATH="$AI_USECASES_DIR:$PATH"' >> ~/.bashrc
source ~/.bashrc

# For zsh users - add to ~/.zshrc
echo 'export AI_USECASES_DIR="$HOME/Documents/ai-use-cases"' >> ~/.zshrc
echo 'export PATH="$AI_USECASES_DIR:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### 4. Verify Installation

```bash
# Check that scripts are executable
ls -l ~/Documents/ai-use-cases/*.sh

# Test help flags
~/Documents/ai-use-cases/setup-project.sh --help
~/Documents/ai-use-cases/document-ai-session.sh --help

# Check directory structure
ls -la ~/Documents/ai-use-cases/
```

You should see:
- `setup-project.sh`, `sync-ai-use-cases.sh`, `document-ai-session.sh` (all with -rwxr-xr-x permissions)
- `by-project/`, `by-date/`, `by-topic/` directories
- `TEMPLATE.md`, `README.md`, etc.

All scripts now support `--help` and `-h` flags for usage information.

### First Project Setup

Now that the central repository is installed, set up your first project:

```bash
# Navigate to your project
cd /path/to/your-project

# Run the setup script
~/Documents/ai-use-cases/setup-project.sh

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
~/Documents/ai-use-cases/document-ai-session.sh

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
├── vscode-extension/         # VS Code extension for one-click documentation (NEW)
│   ├── src/
│   ├── package.json
│   └── README.md
├── document-ai-session.sh    # Interactive AI session documentor (NEW)
├── sync-ai-use-cases.sh      # Sync script (v2.0)
├── setup-project.sh          # Project setup script
├── USAGE-GUIDE.md            # Detailed usage guide (NEW)
└── git-hooks/
    └── post-commit           # Auto-sync git hook
```

**💾 Storage Efficiency:** Files are stored once in `by-project/`. The `by-date/` and `by-topic/` directories contain symlinks for alternate views. This eliminates duplication while maintaining easy browsing.

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

See [USAGE-GUIDE.md](./USAGE-GUIDE.md) for detailed walkthrough.

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
