#!/bin/bash
# AI Use Cases Sync Script v2.0
# Syncs AI use case documentation from project directories to a central location
# Uses symlinks to avoid duplication - files are stored once in by-project/
#
# Usage:
#   ./sync-ai-use-cases.sh [project_path]
#   If no path provided, uses current directory

set -e

# Configuration - Auto-detect hub location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CENTRAL_DIR="${AI_USECASES_DIR:-$SCRIPT_DIR}"
BY_PROJECT_DIR="$CENTRAL_DIR/by-project"
BY_DATE_DIR="$CENTRAL_DIR/by-date"
BY_TOPIC_DIR="$CENTRAL_DIR/by-topic"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Show help
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "AI Use Cases Sync Script v2.0"
    echo ""
    echo "Usage:"
    echo "  $0 [project_path]"
    echo ""
    echo "Description:"
    echo "  Syncs AI use case documentation from project to central repository."
    echo "  Files are stored in by-project/, with symlinks created in"
    echo "  by-date/ and by-topic/ for alternate views."
    echo ""
    echo "Arguments:"
    echo "  project_path    Path to project directory (default: current directory)"
    echo ""
    echo "Examples:"
    echo "  $0                        # Sync current directory"
    echo "  $0 /path/to/project       # Sync specific project"
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

# Get project name from directory name or git repository
if [ -d "$PROJECT_PATH/.git" ]; then
    PROJECT_NAME=$(basename "$(git -C "$PROJECT_PATH" rev-parse --show-toplevel)")
else
    PROJECT_NAME=$(basename "$PROJECT_PATH")
fi

echo -e "${GREEN}=== AI Use Cases Sync v2.0 ===${NC}"
echo "Project: $PROJECT_NAME"
echo "Source: $PROJECT_PATH"
echo "Central: $CENTRAL_DIR"
echo ""

# Find all AI use case files
USE_CASE_DIRS=$(find "$PROJECT_PATH" -type d -name "ai-use-cases" 2>/dev/null || true)

if [ -z "$USE_CASE_DIRS" ]; then
    echo -e "${YELLOW}No ai-use-cases directories found in $PROJECT_PATH${NC}"
    exit 0
fi

# Create project directory in central location
mkdir -p "$BY_PROJECT_DIR/$PROJECT_NAME"

SYNC_COUNT=0
NEW_COUNT=0
UPDATED_COUNT=0

# Process each use case directory found
while IFS= read -r USE_CASE_DIR; do
    if [ ! -d "$USE_CASE_DIR" ]; then
        continue
    fi

    # Find all markdown files in the use case directory
    while IFS= read -r USE_CASE_FILE; do
        if [ ! -f "$USE_CASE_FILE" ]; then
            continue
        fi

        FILENAME=$(basename "$USE_CASE_FILE")

        # Skip README files
        if [[ "$FILENAME" == "README.md" ]]; then
            continue
        fi

        # Validate filename convention (warn but don't fail)
        if ! [[ "$FILENAME" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}_[A-Z]+-[0-9]+_.+\.md$ ]]; then
            echo -e "${YELLOW}⚠ Warning${NC}: $FILENAME doesn't follow naming convention"
            echo "  Expected: YYYY-MM-DD_TICKET-XXXXX_description.md"
        fi

        TARGET_FILE="$BY_PROJECT_DIR/$PROJECT_NAME/$FILENAME"

        # Copy/update file in by-project (canonical storage)
        if [ ! -f "$TARGET_FILE" ]; then
            if cp "$USE_CASE_FILE" "$TARGET_FILE" 2>/dev/null; then
                echo -e "${GREEN}✓ New${NC}: $FILENAME"
                NEW_COUNT=$((NEW_COUNT + 1))
            else
                echo -e "${RED}✗ Failed to copy${NC}: $FILENAME"
                continue
            fi
        elif ! cmp -s "$USE_CASE_FILE" "$TARGET_FILE"; then
            if cp "$USE_CASE_FILE" "$TARGET_FILE" 2>/dev/null; then
                echo -e "${BLUE}↻ Updated${NC}: $FILENAME"
                UPDATED_COUNT=$((UPDATED_COUNT + 1))
            else
                echo -e "${RED}✗ Failed to update${NC}: $FILENAME"
                continue
            fi
        fi

        # Extract date from filename (format: YYYY-MM-DD)
        if [[ "$FILENAME" =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2}) ]]; then
            YEAR="${BASH_REMATCH[1]}"
            MONTH="${BASH_REMATCH[2]}"
            DAY="${BASH_REMATCH[3]}"

            # Create by-date directory structure
            DATE_DIR="$BY_DATE_DIR/$YEAR/$MONTH"
            mkdir -p "$DATE_DIR"

            # Create symlink (with project prefix to avoid name conflicts)
            SYMLINK_PATH="$DATE_DIR/${PROJECT_NAME}_${FILENAME}"
            if [ ! -L "$SYMLINK_PATH" ] || [ ! -e "$SYMLINK_PATH" ]; then
                # Create relative symlink
                if REL_PATH=$(realpath --relative-to="$DATE_DIR" "$TARGET_FILE" 2>/dev/null); then
                    ln -sf "$REL_PATH" "$SYMLINK_PATH" 2>/dev/null || \
                        echo -e "${YELLOW}⚠ Warning${NC}: Failed to create date symlink for $FILENAME"
                fi
            fi
        fi

        # Extract topics from filename (after date and ticket)
        # Format: YYYY-MM-DD_TICKET-XXXXX_topic-words.md
        if [[ "$FILENAME" =~ _([A-Z]+-[0-9]+)_(.+)\.md$ ]]; then
            TICKET="${BASH_REMATCH[1]}"
            TOPIC_SLUG="${BASH_REMATCH[2]}"

            # Create topic directory (use slug for directory name)
            TOPIC_DIR="$BY_TOPIC_DIR/$TOPIC_SLUG"
            mkdir -p "$TOPIC_DIR"

            # Create symlink (with project prefix to avoid name conflicts)
            SYMLINK_PATH="$TOPIC_DIR/${PROJECT_NAME}_${FILENAME}"
            if [ ! -L "$SYMLINK_PATH" ] || [ ! -e "$SYMLINK_PATH" ]; then
                # Create relative symlink
                if REL_PATH=$(realpath --relative-to="$TOPIC_DIR" "$TARGET_FILE" 2>/dev/null); then
                    ln -sf "$REL_PATH" "$SYMLINK_PATH" 2>/dev/null || \
                        echo -e "${YELLOW}⚠ Warning${NC}: Failed to create topic symlink for $FILENAME"
                fi
            fi
        fi

        SYNC_COUNT=$((SYNC_COUNT + 1))
    done < <(find "$USE_CASE_DIR" -type f -name "*.md")

done <<< "$USE_CASE_DIRS"

echo ""
if [ $NEW_COUNT -gt 0 ] || [ $UPDATED_COUNT -gt 0 ]; then
    echo -e "${GREEN}✓ Sync complete!${NC}"
    [ $NEW_COUNT -gt 0 ] && echo "  New: $NEW_COUNT file(s)"
    [ $UPDATED_COUNT -gt 0 ] && echo "  Updated: $UPDATED_COUNT file(s)"
else
    echo -e "${YELLOW}✓ Already in sync${NC} ($SYNC_COUNT file(s))"
fi
echo ""
echo "Storage: $BY_PROJECT_DIR/$PROJECT_NAME/ (canonical)"
echo "Views:"
echo "  By date:  $BY_DATE_DIR/ (symlinks)"
echo "  By topic: $BY_TOPIC_DIR/ (symlinks)"
echo ""
echo -e "${BLUE}💾 Disk usage:${NC} Files stored once, alternate views use symlinks"
