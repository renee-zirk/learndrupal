FROM php:8.3-apache

WORKDIR /

# Install vajalikud paketid ja sõltuvused
RUN apt update && \
    apt install -y unzip wget libzip-dev && \
    docker-php-ext-install mysqli zip

# Lae alla ja paigalda Drupal õigesse kohta
RUN wget https://www.drupal.org/download-latest/zip -O drupal.zip && \
    unzip drupal.zip && \
    mv drupal-*/* /var/www/html && \
    mv drupal-*/.htaccess /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
    rm -rf drupal.zip drupal-*

    # Apache rewrite moodul
RUN a2enmod rewrite

# Lubame .htaccess failid ja rewrite
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf