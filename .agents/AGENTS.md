# Antigravity Rules for entorno-php & OpenSpec (sgt_mvc)

## OpenSpec Mandatory Methodology Rules

Whenever working on any feature, refactoring, bugfix, or architectural task in `src/sgt_mvc/`:

1. **Mandatory OpenSpec Propose Phase**:
   - The agent MUST ALWAYS start by creating or loading an OpenSpec change proposal in `src/sgt_mvc/openspec/changes/<change-name>/` using `proposal.md`, `design.md`, `specs/`, and `tasks.md`.
   - Code edits in `src/sgt_mvc/` MUST NOT be executed until `proposal.md` and `tasks.md` are established.

2. **OpenSpec Context & Standards**:
   - Reference `src/sgt_mvc/openspec/config.yaml` and `src/sgt_mvc/AGENTS.md` for project-wide constraints.
   - Stack: PHP 8.3+, Symfony 7.4 LTS, Doctrine ORM 3.2+, Twig 3.13+, Bootstrap 5, MySQL.
   - Quality Gate Mandatory Checks (`./scripts/pre-pr-check.sh --full` inside `/var/www/html/sgt_mvc`):
     - PHPStan Level 8 (`src/` and `tests/`, 0 errors, explicit `@param array<string, mixed>` PHPDoc types).
     - PHP-CS-Fixer (`@Symfony`, 0 files to fix).
     - Deptrac (`0 Violations`: `Controller -> Manager -> Repository -> Entity`).
     - Symfony & Doctrine Linters (`lint:yaml`, `lint:twig`, `lint:container`, `doctrine:schema:validate`).
     - PHPUnit + Line Coverage `>= 90%`.
   - Domain Concepts: Torneo, Equipo, Jugador, Partido, Categoria, Grupo, Sede, Cancha.

3. **Strict Task Execution & Checkmark Tracking**:
   - Work MUST follow `tasks.md` step-by-step.
   - As each task is completed and verified, the agent MUST update `tasks.md` changing `- [ ]` to `- [x]`.
   - Never complete a task or turn without updating the checkmarks in `tasks.md`.

4. **Archiving Completed Changes**:
   - Upon completion of all tasks in `tasks.md` and full verification (`./scripts/pre-pr-check.sh --full`), the agent MUST archive the change using the `openspec-archive` workflow (`src/sgt_mvc/openspec/changes/archive/<change-name>/`).

5. **Git & Pull Request Rules (Manual Execution by User)**:
   - **Branch creation**: The agent may ONLY create branches matching `fix/<titulo-del-requerimiento>` or `feature/<titulo-del-requerimiento>`.
   - **Forbidden commands**: Never execute `git commit`, `git push`, `gh pr create`, or `glab mr create` (always performed manually by the user).
   - **Final handoff**: Once the Quality Gate passes, provide copy-pasteable **Title** and **Brief Description** blocks for Git (`commit`) and GitHub (`PR/MR`).
