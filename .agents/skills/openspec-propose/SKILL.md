---
name: openspec-propose
description: Propose a new OpenSpec change for sgt_mvc. Creates proposal, design, specs, and tasks artifacts.
---

# OpenSpec Propose Skill

Use this skill when proposing a new change or feature for `sgt_mvc`.

## Input
- Change name (in `kebab-case`, e.g., `gestion-torneos`) or a natural language description of what to build.

## Workflow

1. **Setup Change Directory**:
   - Location: `src/sgt_mvc/openspec/changes/<change-name>/`
   - Create directory `src/sgt_mvc/openspec/changes/<change-name>/` and `specs/` subdirectory.

2. **Generate OpenSpec Artifacts**:
   - **`proposal.md`**: Context, motivation, proposed change, entity impact, migration requirements.
   - **`specs/<domain>/spec.md`**: Domain specifications using **Given / When / Then** scenarios.
   - **`design.md`**: Architecture, Symfony services, Doctrine entities, repositories, and UI components.
   - **`tasks.md`**: Step-by-step implementation checklist with `- [ ]` checkboxes, including test verification.

3. **Completion**:
   - List generated artifacts.
   - Notify user that the change is ready for review and execution.
