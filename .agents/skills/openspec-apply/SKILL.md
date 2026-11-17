---
name: openspec-apply
description: Implement tasks from an OpenSpec change in sgt_mvc. Use when implementing features or following tasks.md.
---

# OpenSpec Apply Skill

Use this skill to implement tasks from an OpenSpec change located in `src/sgt_mvc/openspec/changes/<change-name>/`.

## Workflow

1. **Select Active Change**:
   - Check `src/sgt_mvc/openspec/changes/` for target change.
   - Read `proposal.md`, `design.md`, `specs/`, and `tasks.md` to load full technical context.

2. **Execute Tasks Sequentially**:
   - Find the first uncompleted task in `tasks.md` (`- [ ]`).
   - Implement necessary code changes in `src/sgt_mvc/` adhering to PSR-12, Symfony 7.4, and PHPStan strict rules.
   - Run verification (e.g. PHPUnit / PHPStan) for the task.
   - Mark task complete in `tasks.md` by changing `- [ ]` to `- [x]`.
   - Repeat for remaining tasks.

3. **Pause on Blockers**:
   - If a design flaw or unexpected error occurs, pause, notify the user, and update `design.md` or `tasks.md` if necessary.
