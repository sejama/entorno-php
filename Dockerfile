# Imagen base con PHP 8.3 y Apache
FROM php:8.3-apache

# Actualizar el sistema
RUN apt-get update && apt-get upgrade -y

# Instalación de dependencias
RUN apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    curl \
    libicu-dev

# Crear un usuario no root
RUN useradd -m -u 1000 -s /bin/bash developer

# Instalación de extensiones de PHP
USER root
RUN docker-php-ext-configure intl \
    && docker-php-ext-install pdo pdo_mysql mysqli intl

# Instalación de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar el archivo php.ini personalizado (opcional)
COPY config/php.ini /usr/local/etc/php/

# Habilitar mod_rewrite de Apache
RUN a2enmod rewrite

# Cambiar el propietario del directorio de trabajo
RUN chown -R developer:developer /var/www/html

# Configurar el directorio de trabajo
WORKDIR /var/www/html

# Cambiar al usuario no root
USER developer

# Exponer el puerto 80
EXPOSE 80

# Use bash for the shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a script file sourced by both interactive and non-interactive bash shells
ENV BASH_ENV=/home/developer/.bash_env
RUN touch "${BASH_ENV}"
RUN echo '. "${BASH_ENV}"' >> ~/.bashrc

# Download and install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo node > .nvmrc
RUN nvm install 22
RUN npm install -g npm@latest
