# AI Use Case Hub

Central documentation repository for AI-assisted development workflows across all your projects.

## Overview

This repository serves as the documentation hub - a centralized storage location for all your AI use case documentation. It uses a symlink-based architecture to provide multiple views of your documents without file duplication.

## Architecture

The AI Use Case system consists of two repositories:

- **[ai-use-case-cli](https://github.com/mt-osiris-tools/ai-use-case-cli)** - Command-line tools for managing and documenting use cases
- **ai-use-case-hub** (this repo) - Central storage for all documentation

## Getting Started

### 1. Install the CLI Tools

First, install the CLI tools that will populate this hub:

```bash
curl -fsSL https://raw.githubusercontent.com/mt-osiris-tools/ai-use-case-cli/main/install.sh | bash
```

See the [CLI documentation](https://github.com/mt-osiris-tools/ai-use-case-cli) for detailed installation instructions.

### 2. Clone This Hub

Clone this repository to serve as your documentation hub:

```bash
cd ~/Documents
git clone https://github.com/mt-osiris-tools/ai-use-case-hub.git ai-use-case-hub
```

### 3. Setup Your Projects

Use the CLI to setup projects for documentation:

```bash
cd /path/to/your-project
ai-use-case --init
```

### 4. Start Documenting

Document your AI-assisted sessions:

```bash
ai-use-case document
```

Documentation will automatically sync to this hub!

## Directory Structure

```
ai-use-case-hub/
├── by-project/               # CANONICAL STORAGE - actual files stored here
│   ├── project-name-1/
│   │   ├── 2025-10-13_TICKET-123_feature-description.md
│   │   └── 2025-10-14_TICKET-456_bug-fix.md
│   ├── project-name-2/
│   └── ...
│
├── by-date/                  # VIEW: Symlinks organized by year/month
│   └── 2025/
│       ├── 10/
│       │   ├── project_2025-10-13_TICKET-123_feature.md -> ../../../by-project/...
│       │   └── project_2025-10-14_TICKET-456_bug-fix.md -> ../../../by-project/...
│       └── ...
│
├── by-topic/                 # VIEW: Symlinks organized by topic slug
│   ├── feature-description/
│   │   └── project_2025-10-13_TICKET-123_feature.md -> ../../by-project/...
│   ├── bug-fix/
│   │   └── project_2025-10-14_TICKET-456_bug-fix.md -> ../../by-project/...
│   └── ...
│
├── docs/                     # Example use cases
│   └── ai-use-cases/
│
├── TEMPLATE.md               # Implementation session template (🎯)
├── TEMPLATE-RESEARCH.md      # Research session template (🔬)
├── CHANGELOG.md              # Version history
├── QUICK-REFERENCE.md        # Quick command reference
└── README.md                 # This file
```

### Storage Efficiency

**💾 Zero Duplication:** Files are stored **once** in `by-project/`. The `by-date/` and `by-topic/` directories contain only symlinks, providing multiple views without duplicating files.

**✏️ Edit Anywhere:** When you open a symlink, you're reading the original file. Changes made through symlinks automatically update the canonical file in `by-project/`.

## How It Works

### Workflow

1. **Document**: Create AI use case documentation in your project's `docs/ai-use-cases/` directory
2. **Commit**: Commit the documentation to your project's git repository
3. **Auto-Sync**: Git post-commit hook automatically syncs to this hub
4. **Organize**: Hub organizes docs by project, date, and topic using symlinks

### Session Types

The system supports two types of AI-assisted sessions:

#### 🎯 Implementation Sessions (Code Changes)
For sessions that involve actual code modifications:
- Requires git commits and file changes
- Captures git statistics (files changed, lines added/removed)
- Includes code snippets and technical implementation details
- Uses project-specific tickets (e.g., `PROJ-1234`, `HUB-001`)
- **Template**: `TEMPLATE.md`

**Use for:**
- Implementing new features
- Fixing bugs
- Refactoring code
- Writing tests

#### 🔬 Research Sessions (Exploration)
For exploratory sessions without code changes:
- No git commits required
- Documents query refinement and decision-making
- Captures insights, approaches evaluated, and recommendations
- Uses `RESEARCH-XXX` tickets (auto-generated)
- **Template**: `TEMPLATE-RESEARCH.md`

**Use for:**
- Exploring architectural approaches
- Evaluating multiple technical solutions
- Making technology or design decisions
- Understanding existing codebases
- Investigating issues before implementing fixes
- Back-and-forth conversations to refine complex queries

### File Naming Convention

```
YYYY-MM-DD_TICKET-XXXXX_brief-description.md
```

**Implementation Session Examples:**
- `2025-10-14_PROJ-1234_implement-user-authentication.md`
- `2025-10-15_BUG-567_fix-database-connection-timeout.md`

**Research Session Examples:**
- `2025-10-20_RESEARCH-001_evaluate-database-migration-strategies.md`
- `2025-10-20_RESEARCH-002_compare-authentication-approaches.md`

The naming convention enables automatic organization:
- **Date** (`YYYY-MM-DD`) → Creates symlinks in `by-date/YYYY/MM/`
- **Topic** (`brief-description`) → Creates symlinks in `by-topic/brief-description/`
- **Project** → Files stored in `by-project/project-name/`

## Browsing Documentation

### By Project (Canonical)

View all documentation for a specific project:

```bash
ls ~/Documents/ai-use-case-hub/by-project/my-project/
```

This shows actual files (not symlinks). Edit and delete files here.

### By Date (Chronological)

View documentation by time period:

```bash
# All docs from October 2025
ls ~/Documents/ai-use-case-hub/by-date/2025/10/

# Recent docs
find ~/Documents/ai-use-case-hub/by-date -name "*.md" -type f -printf '%T@ %p\n' | \
  sort -rn | head -10
```

### By Topic (Categorical)

Find related documentation across all projects:

```bash
# All authentication-related docs
ls ~/Documents/ai-use-case-hub/by-topic/authentication/

# Find specific topics
find ~/Documents/ai-use-case-hub/by-topic -name "*database*" -type d
```

## Use Case Template

All documentation should follow the comprehensive template in [TEMPLATE.md](./TEMPLATE.md).

Key sections include:
- 📄 **TL;DR** - Quick summary
- 🏢 **Business Context** - Why the work was needed
- 🔄 **Workflow Steps** - How you accomplished the task
- 🛠️ **Technical Details** - Tools, patterns, insights
- 📊 **Results & Impact** - Measurable outcomes
- 💡 **Key Learnings** - What worked and what didn't
- 🔄 **Replicability** - How to apply this elsewhere

## Analyzing Documentation

### Statistics

```bash
# Total use cases
find by-project -name "*.md" -type f | wc -l

# Use cases per project
for dir in by-project/*/; do
  echo "$(basename "$dir"): $(find "$dir" -name "*.md" | wc -l)"
done
```

### Search

```bash
# Search filenames
find by-project -name "*authentication*"

# Search content
grep -r "Claude Code" by-project --include="*.md"

# Or use the CLI
ai-use-case search authentication
```

### Reports

Generate monthly reports:

```bash
# October 2025 report
find by-date/2025/10 -name "*.md" -type f | \
  while read file; do
    echo "## $(basename "$file")"
    grep "^## 📄 TL;DR" -A 5 "$file" || true
    echo ""
  done > monthly-report-2025-10.md
```

## Version Control

### Hub Repository

You can version control this hub repository to:
- Track documentation evolution over time
- Share documentation across team members
- Backup your documentation

```bash
cd ~/Documents/ai-use-case-hub
git add by-project/
git commit -m "docs: Add new use cases from October"
git push
```

**Note:** The `.gitignore` is configured to ignore symlink directories (`by-date/` and `by-topic/`) since they're regenerated from `by-project/`.

### Project Repositories

Documentation in your project repositories (`docs/ai-use-cases/`) is committed along with your code, providing:
- Context alongside code changes
- Historical record of AI-assisted work
- Team visibility into AI usage patterns

## Best Practices

1. **Document Immediately** - Create documentation right after completing AI-assisted work while details are fresh

2. **Be Specific** - Include ticket numbers, commands used, and measurable outcomes

3. **Capture Context** - Future readers need to understand why decisions were made

4. **Track Metrics** - Document time saved, token usage, and cost for ROI analysis

5. **Share Learnings** - Use the `by-topic/` organization to find and share patterns

6. **Review Regularly** - Periodically review documentation to extract best practices

## Configuration

The hub location can be customized via environment variable:

```bash
# In ~/.bashrc or ~/.zshrc
export AI_USECASES_DIR="$HOME/Documents/ai-use-case-hub"
```

The CLI tools will use this location for syncing documentation.

## Examples

See the `docs/ai-use-cases/` directory for example documentation, including:
- Color encoding fixes across multiple scripts
- Integration with external services
- Refactoring workflows
- Testing strategies

Each example demonstrates the template structure and documentation best practices.

## Related Resources

- **CLI Tools**: [ai-use-case-cli](https://github.com/mt-osiris-tools/ai-use-case-cli)
- **Quick Reference**: [QUICK-REFERENCE.md](./QUICK-REFERENCE.md)
- **Template**: [TEMPLATE.md](./TEMPLATE.md)
- **Changelog**: [CHANGELOG.md](./CHANGELOG.md)
- **Claude Code Instructions**: [CLAUDE.md](./CLAUDE.md)

## Privacy & Security

- **Local Only:** All files are stored locally on your machine
- **No Cloud Sync:** This system does not sync to any cloud service by default
- **Sensitive Data:** Be careful not to include API keys, passwords, or sensitive data
- **Version Control:** Optionally use git to version and share your hub

If sharing across teams:
- Set up a shared network drive for the hub
- Use a shared git repository
- Implement access controls as needed
- Exclude sensitive projects from sync

## Support

- **CLI Issues**: [ai-use-case-cli Issues](https://github.com/mt-osiris-tools/ai-use-case-cli/issues)
- **Hub Issues**: [ai-use-case-hub Issues](https://github.com/mt-osiris-tools/ai-use-case-hub/issues)
- **Discussions**: [GitHub Discussions](https://github.com/mt-osiris-tools/ai-use-case-hub/discussions)

---

**Version**: 2.1.0
**Last Updated**: 2025-10-14
**Architecture**: Documentation Hub (separated from CLI tools)
