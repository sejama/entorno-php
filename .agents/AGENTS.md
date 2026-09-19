# Antigravity Rules for entorno-php & OpenSpec (sgt_mvc)

## OpenSpec Mandatory Methodology Rules

Whenever working on any feature, refactoring, bugfix, or architectural task in `src/sgt_mvc/`:

1. **Mandatory OpenSpec Propose Phase**:
   - The agent MUST ALWAYS start by creating or loading an OpenSpec change proposal in `src/sgt_mvc/openspec/changes/<change-name>/` using `proposal.md`, `design.md`, `specs/`, and `tasks.md`.
   - Code edits in `src/sgt_mvc/` MUST NOT be executed until `proposal.md` and `tasks.md` are established.

2. **OpenSpec Context & Standards**:
   - Reference `src/sgt_mvc/openspec/config.yaml` for project-wide constraints.
   - Stack: PHP 8.3+, Symfony 7.4 LTS, Doctrine ORM 3.x, Twig, Stimulus (UX), Turbo, AssetMapper, MySQL.
   - Quality Standards: PHPStan strict level (0 errors), PHPCodeSniffer (PSR-12), PHPMD.
   - Architecture: Lightweight DDD (Entities, DTOs, Repositories, Managers, EventSubscribers).
   - Domain Concepts: Torneo, Equipo, Jugador, Partido, Categoria, Grupo, Sede, Cancha.

3. **Strict Task Execution & Checkmark Tracking**:
   - Work MUST follow `tasks.md` step-by-step.
   - As each task is completed and verified, the agent MUST update `tasks.md` changing `- [ ]` to `- [x]`.
   - Never complete a task or turn without updating the checkmarks in `tasks.md`.

4. **Archiving Completed Changes**:
   - Upon completion of all tasks in `tasks.md` and full verification (PHPUnit & PHPStan), the agent MUST archive the change using the `openspec-archive` workflow (`src/sgt_mvc/openspec/changes/archive/<change-name>/`).
