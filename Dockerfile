# Imagen base oficial de PHP con Apache
FROM php:8.3-apache

# Instala extensiones de PHP necesarias para Laravel
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath gd

# Habilita mod_rewrite de Apache (necesario para Laravel)
RUN a2enmod rewrite

# Usa el valor de APACHE_DOCUMENT_ROOT como DocumentRoot real
ARG APACHE_DOCUMENT_ROOT
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/000-default.conf

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del proyecto Laravel al contenedor
COPY . .

# Establece los permisos adecuados
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

# Expone el puerto 80
EXPOSE 80

# Comando por defecto al iniciar el contenedor
CMD ["apache2-foreground"]
