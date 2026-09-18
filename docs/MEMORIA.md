# Memoria del Proyecto `entorno-php`

Documentación central de arquitectura, infraestructura Docker, topología multi-proyecto y estándares de desarrollo para el repositorio `entorno-php`.

---

## 1. Visión General y Topología

`entorno-php` es un repositorio orquestador basado en **Docker Compose** y **Dev Containers** diseñado para albergar y desarrollar múltiples aplicaciones PHP/Symfony en contenedores aislados compartiendo infraestructura común (base de datos MySQL, panel de administración y servidor SMTP simulado).

### Estructura de Proyectos

```text
entorno-php/
├── .devcontainer/         # Configuración de VS Code Remote Containers
├── config/                # Configuraciones de MySQL (my.cnf)
├── docs/                  # Memoria y documentación técnica central
│   └── MEMORIA.md
├── mysql/                 # Persistencia de datos MySQL (mysql/data)
├── frontend/              # Recursos frontend globales / landing local
├── src/                   # Directorio raíz montado en /var/www/html
│   ├── index.php          # Selector / Landing de proyectos
│   ├── backend/           # API backend principal (Symfony)
│   ├── comercio/          # Aplicación e-commerce (Symfony + AssetMapper)
│   └── sgt/               # Sistema de gestión de torneos/tareas (Symfony + Quality Tools)
├── AGENTS.md              # Reglas principales para agentes IA
├── SKILL.md               # Skill global del entorno Docker
└── docker-compose.yml     # Orquestación de servicios
```

---

## 2. Infraestructura Docker y Servicios

El entorno expone los siguientes servicios orquestados en `docker-compose.yml`:

| Servicio | Contenedor | Puerto Host | Puerto Contenedor | Descripción / Acceso |
|---|---|---|---|---|
| **PHP + Apache** | `server-php-apache` | `8080` | `80` | http://localhost:8080 (Raíz `/var/www/html`) |
| **MySQL Database** | `server-mysql` | `3307` | `3306` | MySQL 8.0.40 (User: `root`, Pass: `root`) |
| **phpMyAdmin** | `server-phpmyadmin` | `8081` | `80` | http://localhost:8081 (Gestión gráfica BD) |
| **smtp4dev** | `smtp4dev` | `5001` | `80` | http://localhost:5001 (Captura de emails de prueba) |

### Rutas HTTP de los Subproyectos

- **Backend**: http://localhost:8080/backend/public/
- **Comercio**: http://localhost:8080/comercio/public/
- **SGT**: http://localhost:8080/sgt/public/

---

## 3. Matriz de Subproyectos

### 3.1 `src/backend`
- **Propósito**: API REST / Servicios Backend principales.
- **Ruta en contenedor**: `/var/www/html/backend`
- **Documentación destacada**: `README_SECURITY.md`, `SECURITY_EMAIL.md`, `EJEMPLO_FRONTEND_SEGURO.js`.
- **Enfoque clave**: Seguridad en endpoints, autenticación, sanitización de datos y manejo seguro de headers/tokens.

### 3.2 `src/comercio`
- **Propósito**: Plataforma de Comercio Electrónico.
- **Ruta en contenedor**: `/var/www/html/comercio`
- **Frontend Stack**: Symfony AssetMapper (`importmap.php`), Twig.
- **Enfoque clave**: Gestión de catálogo, carrito, usuarios, importmap assets y pruebas unitarias/funcionales con PHPUnit.

### 3.3 `src/sgt`
- **Propósito**: Sistema de Gestión de Torneos de Voley.
- **Ruta en contenedor**: `/var/www/html/sgt`
- **Stack & Calidad**: Symfony 6.4, Doctrine ORM, PHPStan (con baseline), PHPCS (PSR-12), PHP CS Fixer, Infection (Mutation Testing), Deptrac (Arquitectura), Psalm.
- **Documentación destacada**: `README.md`, `TESTING.md`.
- **Enfoque clave**: Alta cobertura de pruebas (Unit, Integration, Functional) y análisis estático riguroso (`composer quality`).

---

## 4. Mejores Prácticas del Proyecto

### A. Ejecución en Docker y Aislamiento

1. **Contexto Obligatorio de Contenedor**: Todos los comandos PHP, Composer, Symfony Console y herramientas de calidad DEBEN ejecutarse dentro de `server-php-apache` o mediante `docker compose exec`.
2. **Especificar la Carpeta de Trabajo**: Al ejecutar Composer o comandos de consola, siempre delimitar el proyecto objetivo:
   ```bash
   docker compose exec server-php-apache composer install --working-dir /var/www/html/<subproject>
   docker compose exec server-php-apache php /var/www/html/<subproject>/bin/console cache:clear
   ```
3. **Persistencia de Base de Datos**: No eliminar la carpeta `mysql/data/` salvo reset explícito del entorno de prueba local.

### B. Estándares de Código Symfony & PHP

1. **Tipado Estricto**: Usar `declare(strict_types=1);`, tipos de retorno explícitos y propiedades tipadas en PHP 8.1+.
2. **Separación de Responsabilidades**:
   - **Controllers**: Ligeros, encargados únicamente de procesar la HTTP Request y retornar HTTP Response / JsonResponse / Render Twig.
   - **Managers / Services**: Encapsulan la lógica de negocio reusable e independiente del framework de presentación.
   - **Repositories**: Exclusivamente para consultas y persistencia Doctrine.
   - **Entities**: Mapeo ORM sin lógica pesada de infraestructura.
3. **Manejo de Errores y Excepciones**: Usar excepciones de dominio personalizadas y evitar suprimir errores silenciosamente.

### C. Base de Datos y Migraciones

1. **Migraciones Doctrine**: Nunca modificar la estructura de base de datos manualmente en producción/dev. Generar y aplicar migraciones:
   ```bash
   docker compose exec server-php-apache php /var/www/html/<subproject>/bin/console doctrine:migrations:diff
   docker compose exec server-php-apache php /var/www/html/<subproject>/bin/console doctrine:migrations:migrate
   ```
2. **Credenciales**: Utilizar `.env.local` para overrides locales. No commitear `.env.local` ni credenciales sensibles al control de versiones.

### D. Seguridad

1. **Sanitización e Inyección**: Usar Prepared Statements mediante Doctrine ORM/DBAL para prevenir Inyección SQL.
2. **Variables Sensibles**: Configurar claves de API y passwords a través de variables de entorno.
3. **Pruebas de Email**: Utilizar la integración con `smtp4dev` (puerto 5001) para capturar emails en desarrollo sin enviar correos reales.

### E. Quality Assurance & Testing

1. **Suite de Calidad (`src/sgt`)**: Ejecutar `composer quality` para asegurar que el código cumple con PSR-12 y pasa el análisis estático.
2. **Pruebas Automatizadas**: Mantener suites de pruebas unitarias, de integración y funcionales. Ejecutar PHPUnit en entorno de test isolated:
   ```bash
   docker compose exec server-php-apache php /var/www/html/<subproject>/vendor/bin/phpunit
   ```

---

## 5. Ecosistema de Memoria para Agentes de IA

Este repositorio utiliza una jerarquía de archivos de reglas y conocimientos para guiar a asistentes y agentes de código:

```text
Ecosistema de Reglas / Memoria
├── AGENTS.md               # Reglas maestras del repositorio y subproyectos
├── SKILL.md                # Habilidades y reglas generales del entorno Docker
├── .agent.md               # Configuración de agente global
├── .prompt.md              # Prompts de contexto para Copilot / Asistentes
├── docs/MEMORIA.md         # (Este archivo) Fuente central de verdad de arquitectura
└── src/
    ├── .agent.md           # Reglas genéricas para proyectos Symfony en src/
    ├── README.md           # Indice de comandos por subproyecto
    ├── backend/SKILL.md    # Reglas específicas de backend (Seguridad & API)
    ├── comercio/SKILL.md   # Reglas específicas de comercio (AssetMapper & E-commerce)
    └── sgt/SKILL.md        # Reglas específicas de SGT (Quality Tools & Testing)
```
