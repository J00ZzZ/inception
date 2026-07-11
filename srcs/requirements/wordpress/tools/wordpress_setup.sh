#!/bin/sh
set -e

# Read secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/credentials)
WP_USER_PASSWORD="${WP_ADMIN_PASSWORD}_user"

echo "Waiting for MariaDB to start..."
# Wait for MariaDB to accept connections
until mysqladmin ping -h mariadb --silent; do
    echo "Database server is not ready yet. Retrying in 2 seconds..."
    sleep 2
done
echo "MariaDB is ready."

# Check if WordPress is already configured
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress is not installed. Installing now..."
    
    cd /var/www/html
    
    # Download WordPress core files
    wp core download --allow-root
    
    # Generate wp-config.php
    wp config create --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="mariadb"
        
    # Install WordPress site
    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"
        
    # Create the secondary user required by the subject
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
        
    echo "WordPress installation completed."
else
    echo "WordPress is already installed and configured."
fi

# Set proper permissions for web root
chown -R www-data:www-data /var/www/html

# Create the run directory for PHP-FPM pid file if it does not exist
mkdir -p /run/php

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F
