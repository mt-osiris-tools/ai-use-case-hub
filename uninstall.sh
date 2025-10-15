#!/bin/bash
# AI Use Case Hub - Uninstall Script

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== AI Use Case Hub Uninstaller ===${NC}"
echo ""

# Confirm uninstall
read -p "Are you sure you want to uninstall AI Use Case Hub? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled"
    exit 0
fi

INSTALL_DIR="${AI_USECASES_DIR:-$HOME/Documents/ai-use-case-hub}"

echo ""
echo "This will:"
echo "  - Remove symlink from ~/.local/bin/"
echo "  - Optionally remove the hub directory"
echo "  - Optionally clean up shell profile entries"
echo ""

# Remove symlink
if [ -L "$HOME/.local/bin/ai-use-case" ]; then
    rm "$HOME/.local/bin/ai-use-case"
    echo -e "${GREEN}✓${NC} Removed symlink from ~/.local/bin/"
else
    echo -e "${YELLOW}⚠${NC} Symlink not found in ~/.local/bin/"
fi

# Ask about hub directory
echo ""
read -p "Remove hub directory ($INSTALL_DIR)? (y/N): " remove_dir
if [[ "$remove_dir" =~ ^[Yy]$ ]]; then
    if [ -d "$INSTALL_DIR" ]; then
        # Warn about synced use cases
        use_case_count=$(find "$INSTALL_DIR/by-project" -name "*.md" -type f 2>/dev/null | wc -l)
        if [ "$use_case_count" -gt 0 ]; then
            echo -e "${RED}⚠ Warning: $use_case_count use case(s) will be deleted!${NC}"
            echo "These files are synced from your projects, but local copies will be removed."
            read -p "Continue? (y/N): " confirm_delete
            if [[ ! "$confirm_delete" =~ ^[Yy]$ ]]; then
                echo "Keeping hub directory"
            else
                rm -rf "$INSTALL_DIR"
                echo -e "${GREEN}✓${NC} Removed hub directory"
            fi
        else
            rm -rf "$INSTALL_DIR"
            echo -e "${GREEN}✓${NC} Removed hub directory"
        fi
    else
        echo -e "${YELLOW}⚠${NC} Hub directory not found"
    fi
else
    echo "Keeping hub directory at: $INSTALL_DIR"
fi

# Ask about shell profile cleanup
echo ""
read -p "Remove entries from shell profile? (y/N): " clean_profile
if [[ "$clean_profile" =~ ^[Yy]$ ]]; then
    for profile in "$HOME/.bashrc" "$HOME/.zshrc"; do
        if [ -f "$profile" ]; then
            if grep -q "AI_USECASES_DIR" "$profile" || grep -q "ai-use-case" "$profile"; then
                # Create backup
                cp "$profile" "${profile}.backup"

                # Remove lines
                sed -i '/AI_USECASES_DIR/d' "$profile" 2>/dev/null || true
                sed -i '/# AI Use Case Hub/d' "$profile" 2>/dev/null || true

                echo -e "${GREEN}✓${NC} Cleaned $(basename "$profile") (backup: ${profile}.backup)"
            fi
        fi
    done
fi

echo ""
echo -e "${GREEN}=== Uninstall Complete ===${NC}"
echo ""
echo "The AI Use Case Hub has been uninstalled."
echo "Note: Project-level setups (docs/ai-use-cases/ and git hooks) remain intact."
echo ""
echo "To reinstall: https://github.com/james401/ai-use-case-hub-"
