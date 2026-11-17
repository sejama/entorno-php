---
name: openspec-archive
description: Archive a completed OpenSpec change in sgt_mvc.
---

# OpenSpec Archive Skill

Use this skill when all tasks in `tasks.md` are complete (`- [x]`) and the change is verified.

## Workflow

1. **Verify Completion**:
   - Check that all tasks in `tasks.md` are marked `- [x]`.
   - Run tests (`phpunit`, `phpstan`) to confirm workspace stability.

2. **Archive Change**:
   - Move the change folder from `src/sgt_mvc/openspec/changes/<change-name>/` to `src/sgt_mvc/openspec/changes/archive/<change-name>/`.
