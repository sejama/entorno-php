# Entorno PHP con Dev Container

Esta configuración permite abrir el proyecto `entorno-php/src` directamente dentro del servicio Docker `server-php-apache`.

## Qué hace

- Usa `docker-compose.yml` existente.
- Abre el workspace en `/var/www/html` dentro del contenedor.
- Monta el código de `./src` en el contenedor.
- Usa el usuario `developer` definido en el Dockerfile.
- Incluye extensiones recomendadas para PHP y Docker.

## Cómo usar

1. Abre la carpeta `entorno-php` en VS Code.
2. Instala la extensión `Dev Containers` o `Remote - Containers` si no está instalada.
3. Ejecuta el comando `Remote-Containers: Reopen in Container`.
4. Si el contenedor no está iniciado, ejecuta la tarea `Docker Compose Up`.

## Symfony y ruta de trabajo

- El repositorio contiene varios proyectos Symfony dentro de `src/`.
- La carpeta `src/` se monta en el contenedor en `/var/www/html`.
- Antes de empezar, elige la carpeta de trabajo Symfony concreta: `src/backend`, `src/comercio` o `src/sgt`.
- En VS Code, trabaja preferiblemente abriendo el subdirectorio del proyecto seleccionado o usando la carpeta raíz `src/` con la subcarpeta clara.

## Acceso al contenedor

- El código fuente estará disponible en `/var/www/html`.
- Puedes abrir un terminal dentro del contenedor desde VS Code.
- Tareas útiles:
  - `Docker Compose Up`
  - `Docker Compose Down`
  - `Open PHP Apache Shell`
  - `Open MySQL Shell`

## Puertos expuestos

- `8080` → Apache
- `8081` → phpMyAdmin
- `5001` → smtp4dev UI
- `3307` → MySQL externo
