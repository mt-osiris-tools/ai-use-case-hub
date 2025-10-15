#!/bin/bash
# AI Use Case Hub - Installation Script
#
# Quick install:
#   curl -fsSL https://raw.githubusercontent.com/james401/ai-use-case-hub/main/install.sh | bash
#
# Or manual:
#   git clone https://github.com/james401/ai-use-case-hub.git ~/Documents/ai-use-case-hub
#   cd ~/Documents/ai-use-case-hub
#   ./install.sh

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}"
cat <<'EOF'
    ___    ____   __  __              ______
   /   |  /  _/  / / / /_______  ____/ / __ \____ ___________
  / /| |  / /   / / / / ___/ _ \/ __  / / / / __ `/ ___/ _ \
 / ___ |_/ /   / /_/ (__  )  __/ /_/ / /_/ / /_/ (__  )  __/
/_/  |_/___/   \____/____/\___/\__,_/\____/\__,_/____/\___/

          Hub Installation
EOF
echo -e "${NC}"

# Determine install directory
if [ -f "ai-use-case" ] && [ -d ".git" ]; then
    # Already in the repository
    INSTALL_DIR="$(pwd)"
    echo -e "${GREEN}✓${NC} Detected existing repository"
else
    # Need to clone
    INSTALL_DIR="$HOME/Documents/ai-use-case-hub"

    if [ -d "$INSTALL_DIR" ]; then
        echo -e "${YELLOW}Repository already exists at $INSTALL_DIR${NC}"
        read -p "Reinstall? (y/N): " reinstall
        if [[ ! "$reinstall" =~ ^[Yy]$ ]]; then
            echo "Installation cancelled"
            exit 0
        fi
        rm -rf "$INSTALL_DIR"
    fi

    echo -e "${CYAN}Cloning repository...${NC}"
    git clone https://github.com/james401/ai-use-case-hub.git "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

echo ""
echo -e "${BLUE}=== Installation ===${NC}"
echo "Install directory: $INSTALL_DIR"
echo ""

# Make scripts executable
echo -e "${CYAN}Making scripts executable...${NC}"
chmod +x ai-use-case
chmod +x setup-project.sh
chmod +x sync-ai-use-cases.sh
chmod +x document-ai-session.sh
echo -e "${GREEN}✓${NC} Scripts are executable"

# Create symlink in user's bin directory
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

if [ -L "$BIN_DIR/ai-use-case" ]; then
    rm "$BIN_DIR/ai-use-case"
fi

ln -s "$INSTALL_DIR/ai-use-case" "$BIN_DIR/ai-use-case"
echo -e "${GREEN}✓${NC} Symlink created: $BIN_DIR/ai-use-case"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo -e "${YELLOW}⚠ $HOME/.local/bin is not in your PATH${NC}"
    echo ""
    echo "Add this to your shell profile (~/.bashrc or ~/.zshrc):"
    echo -e "${CYAN}"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
    echo -e "${NC}"

    read -p "Add to ~/.bashrc now? (Y/n): " add_to_path
    add_to_path=${add_to_path:-y}

    if [[ "$add_to_path" =~ ^[Yy]$ ]]; then
        if [ -f "$HOME/.bashrc" ]; then
            echo '' >> "$HOME/.bashrc"
            echo '# AI Use Case Hub' >> "$HOME/.bashrc"
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
            echo -e "${GREEN}✓${NC} Added to ~/.bashrc"
            echo -e "Run: ${CYAN}source ~/.bashrc${NC} to apply"
        else
            echo -e "${YELLOW}~/.bashrc not found, please add manually${NC}"
        fi
    fi
fi

# Setup environment variable (optional)
echo ""
read -p "Add AI_USECASES_DIR to shell profile? (Y/n): " add_env
add_env=${add_env:-y}

if [[ "$add_env" =~ ^[Yy]$ ]]; then
    SHELL_PROFILE=""

    if [ -f "$HOME/.bashrc" ]; then
        SHELL_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.zshrc" ]; then
        SHELL_PROFILE="$HOME/.zshrc"
    fi

    if [ -n "$SHELL_PROFILE" ]; then
        if ! grep -q "AI_USECASES_DIR" "$SHELL_PROFILE"; then
            echo "export AI_USECASES_DIR=\"$INSTALL_DIR\"" >> "$SHELL_PROFILE"
            echo -e "${GREEN}✓${NC} Added AI_USECASES_DIR to $SHELL_PROFILE"
        else
            echo -e "${YELLOW}AI_USECASES_DIR already in $SHELL_PROFILE${NC}"
        fi
    fi
fi

echo ""
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo ""
echo -e "${YELLOW}Quick Start:${NC}"
echo -e "  1. Reload your shell: ${CYAN}source ~/.bashrc${NC}"
echo -e "  2. Navigate to a project: ${CYAN}cd /path/to/your-project${NC}"
echo -e "  3. Setup the project: ${CYAN}ai-use-case --init${NC}"
echo -e "  4. Document AI sessions: ${CYAN}ai-use-case document${NC}"
echo ""
echo -e "${YELLOW}Available Commands:${NC}"
echo -e "  ${GREEN}ai-use-case --init${NC}       Setup current project"
echo -e "  ${GREEN}ai-use-case document${NC}     Document an AI session"
echo -e "  ${GREEN}ai-use-case sync${NC}         Sync use cases to hub"
echo -e "  ${GREEN}ai-use-case search <term>${NC} Search use cases"
echo -e "  ${GREEN}ai-use-case stats${NC}        View statistics"
echo -e "  ${GREEN}ai-use-case --help${NC}       Show all commands"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo -e "  Run ${CYAN}ai-use-case --help${NC} for full usage guide"
echo -e "  Read ${CYAN}$INSTALL_DIR/README.md${NC} for detailed documentation"
echo ""
echo -e "${BLUE}Happy documenting! 🎉${NC}"
