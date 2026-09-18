# Skill de Entorno Docker y Arquitectura para `entorno-php`

## Contexto y Referencias

- Repositorio orquestador para aplicaciones Symfony en `entorno-php/src`.
- Subproyectos activos: `src/backend`, `src/comercio` y `src/sgt`.
- Contenedor ejecutor principal: `server-php-apache` (código fuente en `/var/www/html`).
- **Memoria Principal del Proyecto**: Consulta [`docs/MEMORIA.md`](docs/MEMORIA.md) para detalles completos de arquitectura, servicios y puertos.

## Reglas de Trabajo y Mejores Prácticas

1. **Aislamiento en Contenedor**: Ejecuta **todos** los comandos PHP, Composer y de consola Symfony dentro del contenedor `server-php-apache`. Nunca ejecutes PHP/Composer directamente en la máquina host.
2. **Contexto de Subproyecto**: Antes de ejecutar cualquier tarea, identifica el subproyecto de destino (`backend`, `comercio` o `sgt`) y usa `--working-dir`:
   ```bash
   docker compose exec server-php-apache composer install --working-dir /var/www/html/<subproyecto>
   docker compose exec server-php-apache php /var/www/html/<subproyecto>/bin/console <comando>
   ```
3. **Estado del Stack**: Verifica la disponibilidad del stack con `docker compose ps`. Si los contenedores están detenidos, inicia con `docker compose up -d` o la tarea `Docker Compose Up`.
4. **Acceso a Base de Datos**: Para interactuar con MySQL vía cliente CLI:
   ```bash
   docker compose exec server-mysql mysql -uroot -proot
   ```
5. **Captura de Correos**: Para verificar el envío de emails en desarrollo, accede a `smtp4dev` en `http://localhost:5001`.

## Guía de Troubleshooting Rápido

- **Error de Conexión a BD**: Revisa que el contenedor `server-mysql` esté corriendo y escucha en el puerto interno 3306 (puerto host `3307`).
- **Permisos de Escritura en `var/`**: Si un subproyecto da error de caché o logs, limpia el caché con `bin/console cache:clear` dentro del contenedor.
- **Puerto 8080/8081 en Uso**: Asegúrate de que no haya otros servicios locales compitiendo por los puertos de Apache (8080) o phpMyAdmin (8081).

## Objetivo

Garantizar un desarrollo consistente y aislado dentro de Docker, maximizando la estabilidad del entorno y la compatibilidad entre subproyectos.
