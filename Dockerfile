FROM php:8.2-apache

# ---- System dependencies (mapped from apt packages) ----
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libmagickwand-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# ---- PHP extensions required by Nextcloud ----
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        pdo_mysql \
        curl \
        mbstring \
        intl \
        gmp \
        xml \
        zip \
        opcache

# ---- Enable Apache modules (from official guide) ----
RUN a2enmod rewrite headers env dir mime

# ---- Copy Nextcloud application ----
COPY nextcloud-32.0.5/nextcloud/ /var/www/nextcloud/

# ---- Permissions ----
RUN chown -R www-data:www-data /var/www/nextcloud \
    && chmod -R 755 /var/www/nextcloud

# ---- Set working directory ----
WORKDIR /var/www/nextcloud

EXPOSE 80
