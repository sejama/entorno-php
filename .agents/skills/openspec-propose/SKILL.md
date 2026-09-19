---
name: openspec-propose
description: Propose a new OpenSpec change for sgt_mvc. Creates proposal, design, specs, and tasks artifacts.
---

# OpenSpec Propose Skill

Use this skill when proposing a new change or feature for .

## Input
- Change name (in , e.g., ) or a natural language description of what to build.

## Workflow

1. **Setup Change Directory**:
   - Location: 
   - If CLI is available, run .
   - Otherwise, create directory  and a  with .

2. **Generate OpenSpec Artifacts**:
   - ****: Context, motivation, proposed change, entity impact, migration requirements.
   - ****: Domain specifications using **Given / When / Then** scenarios.
   - ****: Architecture, Symfony services, Doctrine entities, repositories, and UI components.
   - ****: Step-by-step implementation checklist with  checkboxes, including test verification.

3. **Completion**:
   - List generated artifacts.
   - Notify user that the change is ready for review and execution.
