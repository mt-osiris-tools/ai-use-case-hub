#!/bin/bash
# AI Use Cases Setup Script
# Sets up AI use case automation for any project
#
# Usage:
#   ./setup-project.sh [project_path]
#   If no path provided, uses current directory

set -e

# Configuration
CENTRAL_DIR="${AI_USECASES_DIR:-$HOME/Documents/ai-use-cases}"
HOOK_SOURCE="$CENTRAL_DIR/git-hooks/post-commit"
SYNC_SCRIPT="$CENTRAL_DIR/sync-ai-use-cases.sh"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Show help
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "AI Use Cases Setup Script"
    echo ""
    echo "Usage:"
    echo "  $0 [project_path]"
    echo ""
    echo "Description:"
    echo "  Sets up AI use case documentation automation for a project."
    echo "  Creates docs/ai-use-cases/ directory, installs git hook,"
    echo "  and performs initial sync to central repository."
    echo ""
    echo "Arguments:"
    echo "  project_path    Path to project directory (default: current directory)"
    echo ""
    echo "Examples:"
    echo "  $0                        # Setup current directory"
    echo "  $0 /path/to/project       # Setup specific project"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    exit 0
fi

# Get project path (use provided argument or current directory)
PROJECT_PATH="${1:-$(pwd)}"

# Ensure we're in a project directory
if [ ! -d "$PROJECT_PATH" ]; then
    echo -e "${RED}Error: Directory $PROJECT_PATH does not exist${NC}"
    exit 1
fi

# Check if it's a git repository
if [ ! -d "$PROJECT_PATH/.git" ]; then
    echo -e "${RED}Error: $PROJECT_PATH is not a git repository${NC}"
    echo "Initialize git first: cd $PROJECT_PATH && git init"
    exit 1
fi

PROJECT_NAME=$(basename "$(git -C "$PROJECT_PATH" rev-parse --show-toplevel)")

echo -e "${BLUE}=== AI Use Cases Project Setup ===${NC}"
echo "Project: $PROJECT_NAME"
echo "Path: $PROJECT_PATH"
echo ""

# Create ai-use-cases directory if it doesn't exist
AI_USECASES_DIR="$PROJECT_PATH/docs/ai-use-cases"
if [ ! -d "$AI_USECASES_DIR" ]; then
    mkdir -p "$AI_USECASES_DIR"
    echo -e "${GREEN}✓${NC} Created: docs/ai-use-cases/"

    # Create a README
    cat > "$AI_USECASES_DIR/README.md" <<EOF
# AI Use Cases

This directory contains documentation of AI-assisted development workflows used in this project.

## Format

Each use case is documented in a markdown file with the following naming convention:
\`\`\`
YYYY-MM-DD_TICKET-XXXXX_brief-description.md
\`\`\`

## Syncing

Use cases are automatically synced to a central location at:
\`$CENTRAL_DIR\`

### Manual Sync

To manually sync use cases:
\`\`\`bash
$SYNC_SCRIPT $PROJECT_PATH
\`\`\`

### Automatic Sync

AI use cases are automatically synced after each git commit that modifies files in this directory.

## Template

See the central repository for use case templates and examples.
EOF
    echo -e "${GREEN}✓${NC} Created: docs/ai-use-cases/README.md"
else
    echo -e "${YELLOW}⚠${NC} docs/ai-use-cases/ already exists"
fi

# Install git hook
GIT_HOOKS_DIR="$PROJECT_PATH/.git/hooks"
POST_COMMIT_HOOK="$GIT_HOOKS_DIR/post-commit"

if [ ! -f "$HOOK_SOURCE" ]; then
    echo -e "${RED}Error: Hook source not found: $HOOK_SOURCE${NC}"
    exit 1
fi

# Check if post-commit hook already exists
if [ -f "$POST_COMMIT_HOOK" ]; then
    # Check if our hook is already installed
    if grep -q "AI Use Cases" "$POST_COMMIT_HOOK"; then
        echo -e "${YELLOW}⚠${NC} Git hook already installed"
    else
        # Backup existing hook
        BACKUP_HOOK="$POST_COMMIT_HOOK.backup.$(date +%Y%m%d%H%M%S)"
        cp "$POST_COMMIT_HOOK" "$BACKUP_HOOK"
        echo -e "${YELLOW}⚠${NC} Existing hook backed up to: $(basename "$BACKUP_HOOK")"

        # Append our hook to existing hook
        echo "" >> "$POST_COMMIT_HOOK"
        cat "$HOOK_SOURCE" >> "$POST_COMMIT_HOOK"
        echo -e "${GREEN}✓${NC} Git hook appended to existing post-commit hook"
    fi
else
    # Install fresh hook
    cp "$HOOK_SOURCE" "$POST_COMMIT_HOOK"
    chmod +x "$POST_COMMIT_HOOK"
    echo -e "${GREEN}✓${NC} Git post-commit hook installed"
fi

# Add to .gitignore if not already present
GITIGNORE="$PROJECT_PATH/.gitignore"
if [ -f "$GITIGNORE" ]; then
    if ! grep -q "^# AI Use Cases - ignore local notes" "$GITIGNORE"; then
        echo "" >> "$GITIGNORE"
        echo "# AI Use Cases - ignore local notes" >> "$GITIGNORE"
        echo "docs/ai-use-cases/*.draft.md" >> "$GITIGNORE"
        echo "docs/ai-use-cases/*.local.md" >> "$GITIGNORE"
        echo -e "${GREEN}✓${NC} Added AI use cases patterns to .gitignore"
    else
        echo -e "${YELLOW}⚠${NC} .gitignore already configured"
    fi
fi

# Perform initial sync
echo ""
echo -e "${BLUE}Performing initial sync...${NC}"
if "$SYNC_SCRIPT" "$PROJECT_PATH"; then
    echo ""
    echo -e "${GREEN}=== Setup Complete! ===${NC}"
    echo ""
    echo "What's next?"
    echo "1. Create AI use case docs in: $AI_USECASES_DIR"
    echo "2. Use format: YYYY-MM-DD_TICKET-XXXXX_description.md"
    echo "3. Commit changes - use cases will auto-sync!"
    echo ""
    echo "Manual sync: $SYNC_SCRIPT"
    echo "View synced: ls $CENTRAL_DIR/by-project/$PROJECT_NAME/"
else
    echo -e "${RED}Initial sync failed${NC}"
    exit 1
fi
