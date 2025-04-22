FROM php:8.3-apache

WORKDIR /

# Install vajalikud paketid ja uuendused
RUN apt update && \
    apt install -y unzip wget libzip-dev && \
    docker-php-ext-install mysqli zip

# Lae alla Drupal
RUN wget https://www.drupal.org/download-latest/zip -O drupal.zip && \
    unzip drupal.zip && \
    mv drupal-* /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    rm drupal.zip

# Apache'i rewrite moodul
RUN a2enmod rewrite