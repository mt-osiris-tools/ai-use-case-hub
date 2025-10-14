# AI Session Documentor - VS Code Extension

Document your AI-assisted coding sessions with one command. Works seamlessly with Claude Code and GitHub Copilot.

## Features

- **One-Click Documentation**: Document your AI session with a single command
- **Interactive Prompts**: Guided workflow to capture all relevant details
- **Git Integration**: Automatically captures file changes, diffs, and commits
- **Multiple Triggers**:
  - Command Palette: `AI Session: Document AI Session`
  - Keyboard Shortcut: `Ctrl+Alt+D` (or `Cmd+Alt+D` on Mac)
  - GitHub Copilot Chat: Type `@workspace /document-ai-session`
- **Auto-Sync**: Integrates with ai-use-cases central repository

## Installation

### From Source (Development)

1. Clone the ai-use-cases repository:
   ```bash
   git clone https://github.com/james401/ai-use-case-hub-.git
   cd ai-use-case-hub-/vscode-extension
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Compile the extension:
   ```bash
   npm run compile
   ```

4. Open in VS Code and press F5 to launch Extension Development Host

### From .vsix Package

1. Download the latest `.vsix` file from releases
2. In VS Code, go to Extensions view
3. Click "..." menu → "Install from VSIX..."
4. Select the downloaded `.vsix` file

## Setup

1. Ensure you have the ai-use-cases repository set up:
   ```bash
   git clone https://github.com/james401/ai-use-case-hub-.git ~/Documents/ai-use-cases
   ```

2. Set up your project with ai-use-cases:
   ```bash
   ~/Documents/ai-use-cases/setup-project.sh
   ```

3. Configure the extension (optional):
   - Open Settings (Cmd/Ctrl + ,)
   - Search for "AI Session Documentor"
   - Adjust settings as needed

## Usage

### From Command Palette

1. Open Command Palette (`Cmd/Ctrl + Shift + P`)
2. Type "Document AI Session"
3. Press Enter
4. Follow the interactive prompts in the terminal

### From Keyboard Shortcut

1. Press `Ctrl+Alt+D` (or `Cmd+Alt+D` on Mac)
2. Follow the interactive prompts in the terminal

### From GitHub Copilot Chat

1. Open GitHub Copilot Chat
2. Type: `@workspace document my AI session`
3. Or use the command: `/document-ai-session`
4. Follow the prompts

### From Terminal (Direct)

You can also run the script directly:
```bash
~/Documents/ai-use-cases/document-ai-session.sh
```

## Configuration

| Setting | Default | Description |
|---------|---------|-------------|
| `aiSessionDocumentor.enabled` | `true` | Enable/disable the extension |
| `aiSessionDocumentor.scriptPath` | `~/Documents/ai-use-cases/document-ai-session.sh` | Path to the documentation script |
| `aiSessionDocumentor.autoOpenEditor` | `true` | Auto-open generated docs in editor |
| `aiSessionDocumentor.autoCommit` | `false` | Auto-commit generated documentation |

## What Gets Documented

The extension captures:
- Session timestamp and duration
- AI tool used (Claude Code, GitHub Copilot, etc.)
- Files modified during the session
- Git diff of changes
- Ticket/issue reference
- Business context and objectives
- Technical details and patterns used
- Success metrics and learnings
- Replicability framework

## Documentation Template

Generated documents follow a comprehensive template including:
- TL;DR summary
- Business context
- Step-by-step workflow
- Technical details with code snippets
- Results and impact metrics
- Key learnings and best practices
- Replicability guidelines

## Integration with AI Use Cases Hub

This extension integrates with the [AI Use Cases Hub](https://github.com/james401/ai-use-case-hub-) system:

1. Documents are saved to `docs/ai-use-cases/` in your project
2. Post-commit hook automatically syncs to central repository
3. Documents are organized by:
   - Project (canonical storage)
   - Date (YYYY/MM)
   - Topic/feature

## Troubleshooting

### Script not found

Ensure the ai-use-cases repository is cloned to the default location:
```bash
ls ~/Documents/ai-use-cases/document-ai-session.sh
```

If it's in a different location, update the setting `aiSessionDocumentor.scriptPath`.

### Project not set up

Run the setup script in your project:
```bash
cd /path/to/your/project
~/Documents/ai-use-cases/setup-project.sh
```

### Terminal doesn't open

The extension launches an integrated terminal. If it doesn't appear, check:
- VS Code has permission to execute shell scripts
- The script path is correct in settings
- The script is executable: `chmod +x ~/Documents/ai-use-cases/document-ai-session.sh`

## Development

To contribute or modify this extension:

```bash
# Clone and install
git clone https://github.com/james401/ai-use-case-hub-.git
cd ai-use-case-hub-/vscode-extension
npm install

# Watch mode for development
npm run watch

# Compile
npm run compile

# Package extension
npm install -g vsce
vsce package
```

## License

MIT

## Links

- [GitHub Repository](https://github.com/james401/ai-use-case-hub-)
- [Documentation](https://github.com/james401/ai-use-case-hub-/blob/main/README.md)
- [Issue Tracker](https://github.com/james401/ai-use-case-hub-/issues)
