# AI Coding Session Documentation Automation

## Context
We have an existing project that needs enhancement. We regularly conduct AI-assisted coding sessions using Claude Code or GitHub Copilot, and we need to document these sessions systematically using our established documentation template.

## Objective
Create a VS Code extension command that automatically triggers our "ai-use-case documentator" workflow after completing an AI-assisted coding session.

## Requirements

### 1. VS Code Command Implementation
- Create a VS Code command called `document-ai-session` that can be triggered via:
  - Command palette (Cmd/Ctrl + Shift + P)
  - Keyboard shortcut (suggest: Ctrl+Alt+D)
  - Optional: Status bar button

### 2. Session Data Collection
The command should capture:
- Session timestamp (start and end times)
- AI tool used (Claude Code or GitHub Copilot)
- Files modified during the session
- Git diff of changes made
- Number of AI interactions/suggestions accepted
- Brief session summary (prompt user for input)

### 3. Documentation Template Integration
- Use our existing documentation template located at: [specify path/template.md]
- Auto-populate template fields with collected session data
- Generate a markdown file with naming convention: `ai-session-YYYY-MM-DD-HHmm.md`
- Save to designated documentation folder: `./docs/ai-sessions/`

### 4. Workflow Automation
- Detect session end triggers:
  - Manual command invocation
  - Git commit with specific message pattern (e.g., containing "AI session end")
  - Configurable idle timeout (default: 30 minutes)
- Option to review/edit documentation before saving
- Automatic git commit of documentation file with message: "docs: AI session [date] [tool]"

### 5. Configuration
Create settings in `.vscode/settings.json`:
```json
{
  "aiSessionDocumentor": {
    "enabled": true,
    "autoTriggerOnCommit": true,
    "idleTimeout": 30,
    "templatePath": "./templates/ai-session-template.md",
    "outputPath": "./docs/ai-sessions/",
    "includeGitDiff": true,
    "promptForSummary": true
  }
}
```

### 6. Implementation Steps
1. Create VS Code extension structure
2. Implement session tracking logic
3. Create command registration
4. Build template processing engine
5. Add git integration for diffs and auto-commits
6. Create configuration schema
7. Add error handling and validation
8. Write tests for the command

## Current Project Structure
[Provide your current project structure here]

## Documentation Template
[Paste your existing template here or provide its location]

## Additional Context
- We want this to be lightweight and non-intrusive
- Should work seamlessly with both Claude Code and GitHub Copilot
- Need ability to manually override or skip documentation for certain sessions
- Consider adding metrics dashboard in future iteration

## Success Criteria
- Command successfully captures all session data
- Documentation is generated accurately using our template
- Minimal manual intervention required
- Works consistently across different AI coding tools
- Documentation is automatically versioned in git