# Changelog

## Version 2.0.0 - 2025-10-14

### 🚀 Major Improvement: Symlink-Based Structure

**Changed:** Eliminated file duplication by using symlinks for alternate views

#### Before (v1.0)
- Files were copied to 3 locations:
  - `by-project/` (copy 1)
  - `by-date/` (copy 2)  
  - `by-topic/` (copy 3)
- **Disk usage:** 3x file size per use case
- **Maintenance:** Changes needed in 3 places
- **Inconsistency risk:** Copies could diverge

#### After (v2.0)
- Files stored once in `by-project/` (canonical)
- `by-date/` and `by-topic/` use symlinks
- **Disk usage:** 1x file size per use case (66% reduction)
- **Maintenance:** Edit once in canonical location
- **Consistency:** Single source of truth

#### Technical Changes
- Updated `sync-ai-use-cases.sh` to create symlinks instead of copies
- Uses relative paths for portability
- Symlinks created with format: `project_filename.md -> ../../by-project/project/filename.md`
- Detects and handles existing files vs new files vs updated files

#### Benefits
- **Storage Efficiency:** ~66% reduction in disk usage
- **Data Integrity:** Single source of truth prevents inconsistencies
- **Performance:** Faster sync (no multiple file copies)
- **Maintenance:** Edit/delete files in one location only
- **Compatibility:** Symlinks work transparently with most tools

#### Breaking Changes
None - existing workflows continue to work unchanged

#### Migration
- Existing deployments: Delete old `by-date/` and `by-topic/` directories, re-run sync
- Files in `by-project/` are preserved and become canonical storage
- Symlinks automatically created on next sync

---

## Version 1.0.0 - 2025-10-14

### Initial Release

**Features:**
- Central repository for AI use cases across all projects
- Three-way organization: by-project, by-date, by-topic
- Automatic sync via git post-commit hooks
- Project setup script for easy onboarding
- Comprehensive documentation and templates
- Bash aliases for quick access
