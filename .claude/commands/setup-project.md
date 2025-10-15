# Setup AI Use Cases for Current Project

You are helping the user set up AI use case documentation automation for their current project.

## Your Task

Configure the current project to automatically sync AI use case documentation to the central repository.

## Steps

1. Verify we're in a git repository:
   ```bash
   git rev-parse --show-toplevel
   ```

2. Check current status:
   ```bash
   # Check if already set up
   ls -la docs/ai-use-cases/ 2>/dev/null && echo "Already set up" || echo "Not set up"
   ls -la .git/hooks/post-commit 2>/dev/null && grep -q "AI Use Cases" .git/hooks/post-commit && echo "Hook installed" || echo "Hook not installed"
   ```

3. Run the setup script:
   ```bash
   ~/Documents/ai-use-case-hub/setup-project.sh
   ```

4. Verify the setup:
   ```bash
   # Check what was created
   ls -la docs/ai-use-cases/
   ls -la .git/hooks/post-commit

   # Show the user where files will be synced
   echo "Files will sync to: ~/Documents/ai-use-case-hub/by-project/$(basename $(git rev-parse --show-toplevel))/"
   ```

5. Explain to the user:
   - How to create use case documents (naming convention)
   - That commits will auto-sync to the central repository
   - Where to find synced files (by-project, by-date, by-topic)

## What Gets Set Up

- `docs/ai-use-cases/` directory in the project
- Git post-commit hook for auto-syncing
- `.gitignore` patterns for draft files
- README in the ai-use-cases directory

## Next Steps

Suggest the user:
1. Document their next AI-assisted session
2. Review the template at `~/Documents/ai-use-case-hub/TEMPLATE.md`
3. Use `/document-session` command after their next coding session
