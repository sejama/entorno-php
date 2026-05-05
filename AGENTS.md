# Agentes para `entorno-php`

Este repositorio usa Docker Compose y el contenedor `server-php-apache` para el entorno de desarrollo.

## Agente de trabajo

- Nombre sugerido: `entorno-php-dev`
- Servicio Docker principal: `server-php-apache`
- Carpeta de trabajo: `src/`
- Ruta en contenedor: `/var/www/html/`
- Subproyectos Symfony disponibles: `src/backend`, `src/comercio`, `src/sgt`
- Comandos principales:
  - `docker compose up -d`
  - `docker compose exec server-php-apache bash`
  - `docker compose exec server-php-apache composer install --working-dir /var/www/html/<subproject>`

## Recomendación

Abre siempre el workspace con Remote Containers / Dev Containers para trabajar con el contexto del contenedor y garantizar que todo el código de `src` esté disponible dentro del contenedor.

- Antes de comenzar, selecciona el proyecto Symfony a editar: `src/backend`, `src/comercio` o `src/sgt`.
- Usa `src/.agent.md` para el flujo genérico de Symfony, y los archivos `SKILL.md` en cada subcarpeta para reglas específicas del proyecto.
