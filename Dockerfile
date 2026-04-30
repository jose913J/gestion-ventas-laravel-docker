FROM richarvey/nginx-php-fpm:latest

COPY . .

# Configuración de la imagen
ENV SKIP_COMPOSER 0
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Configuración de Laravel
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Permisos para storage
RUN chmod -R 777 /var/www/html/storage

# Instalar dependencias
RUN composer install --no-dev --optimize-autoloader

# Limpiar y cachear configuraciones (SIN migraciones)
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache
RUN php artisan config:clear

EXPOSE 80

CMD ["/start.sh"]

CMD ["/start.sh"]
Elimino migraciones automáticas del Dockerfile
