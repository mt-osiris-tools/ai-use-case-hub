# Sync AI Use Cases

You are helping the user manually sync AI use case documentation from their current project to the central repository.

## Your Task

Run the sync script to copy use case documents from the current project to the central hub.

## Steps

1. Verify we're in a project with use cases:
   ```bash
   # Find all use case files
   find docs/ai-use-cases -name "*.md" -type f 2>/dev/null | head -10
   ```

2. Show what will be synced:
   ```bash
   echo "Files to sync:"
   find docs/ai-use-cases -name "*.md" -type f ! -name "README.md" 2>/dev/null
   ```

3. Run the sync:
   ```bash
   ~/Documents/ai-use-case-hub/sync-ai-use-cases.sh
   ```

4. Show the results:
   ```bash
   # Show where files were synced
   PROJECT_NAME=$(basename $(git rev-parse --show-toplevel 2>/dev/null) || basename $(pwd))
   echo "Synced to central repository:"
   ls -lh ~/Documents/ai-use-case-hub/by-project/$PROJECT_NAME/
   ```

5. Optionally show recent use cases across all projects:
   ```bash
   echo "Recent use cases (all projects):"
   find ~/Documents/ai-use-case-hub/by-date -name "*.md" -type l -printf '%T@ %p\n' 2>/dev/null | sort -rn | head -5 | cut -d' ' -f2- | xargs -I {} basename {}
   ```

## When to Use This

- After creating/updating use case documents
- To verify sync is working
- If automatic sync didn't trigger
- To sync multiple old use cases at once

## Note

Auto-sync happens automatically on git commit if the post-commit hook is installed. Manual sync is usually only needed for testing or troubleshooting.
