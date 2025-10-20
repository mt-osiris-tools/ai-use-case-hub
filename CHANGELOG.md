# Changelog

## Version 2.1.0 - 2025-10-20

### 🔬 Research Session Support

**Added:** Support for research and exploratory AI sessions without code changes

#### New Features
- **TEMPLATE-RESEARCH.md**: Comprehensive template for documenting research sessions
  - Research context and initial query documentation
  - Query evolution tracking through iterations
  - Key insights discovered section
  - Approaches evaluated with pros/cons
  - Final decision and recommendation documentation
  - Research impact and replicability framework
- **RESEARCH-XXX ticket format**: Auto-generated ticket numbering for research sessions
- **Session type documentation**: Clear guidance on when to use each template

#### Documentation Updates
- **README.md**: Added "Session Types" section explaining implementation vs research sessions
- **README.md**: Updated file naming examples to include RESEARCH-XXX format
- **README.md**: Updated directory structure to show both templates
- **QUICK-REFERENCE.md**: Added research session workflow and commands

#### Use Cases
Research sessions are ideal for:
- Exploring architectural approaches
- Evaluating multiple technical solutions
- Making technology or design decisions
- Understanding existing codebases without modifications
- Investigating issues before implementing fixes
- Back-and-forth conversations to refine complex queries

#### CLI Integration
This hub update works with **CLI v2.2.0** which includes:
- Automatic session type detection
- Research-specific template generation
- RESEARCH-XXX ticket auto-generation
- Race condition protection for concurrent research sessions

---

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
