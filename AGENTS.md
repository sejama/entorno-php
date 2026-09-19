# Agentes para `entorno-php`

Este repositorio usa Docker Compose y el contenedor `server-php-apache` para el entorno de desarrollo.

## Agente de trabajo

- Nombre sugerido: `entorno-php-dev`
- Servicio Docker principal: `server-php-apache`
- Carpeta de trabajo: `src/`
- Ruta en contenedor: `/var/www/html/`
- Subproyecto principal: `src/sgt_mvc` (PHP 8.3+, Symfony 7.4 LTS)
- Comandos principales:
  - `docker compose up -d`
  - `docker compose exec server-php-apache bash`
  - `docker compose exec server-php-apache composer --working-dir /var/www/html/sgt_mvc quality`
  - `docker compose exec server-php-apache php /var/www/html/sgt_mvc/vendor/bin/phpunit -c /var/www/html/sgt_mvc/phpunit.xml.dist`

## Regla Mandatoria: Uso Estricto de OpenSpec

Para cualquier modificación, nueva característica, refactorización o corrección en `src/sgt_mvc/`, el agente **DEBE** seguir siempre el flujo OpenSpec:
1. Crear/cargar el cambio en `src/sgt_mvc/openspec/changes/<nombre-cambio>/` (`proposal.md`, `design.md`, `specs/`, `tasks.md`).
2. Ejecutar las tareas de `tasks.md` secuencialmente actualizando los casilleros `- [ ]` a `- [x]` al completar cada paso.
3. Archivar el cambio en `src/sgt_mvc/openspec/changes/archive/<nombre-cambio>/` una vez finalizadas las verificaciones.
