# Skill de entorno Docker para `entorno-php`

## Contexto

- El repositorio contiene varios proyectos Symfony dentro de `entorno-php/src`.
- Los subproyectos principales son `src/backend`, `src/comercio` y `src/sgt`.
- El contenedor PHP principal es `server-php-apache`.
- El código fuente se monta como volumen en `/var/www/html`.
- Antes de ejecutar comandos o hacer cambios, elige la carpeta de trabajo Symfony concreta.

## Reglas de trabajo

1. Usa siempre el contexto del contenedor para ejecutar PHP y comandos del servidor.
2. Si necesitas un terminal, abre el terminal integrado de VS Code dentro del contenedor.
3. No asumas que el contenedor ya está iniciado: verifica con `docker compose ps` o ejecuta `Docker Compose Up`.
4. Para MySQL usa `docker compose exec server-mysql mysql -uroot -proot`.

## Objetivo

Facilitar el desarrollo desde VS Code con acceso constante al proyecto `entorno-php/src` y a los servicios Docker del stack.
