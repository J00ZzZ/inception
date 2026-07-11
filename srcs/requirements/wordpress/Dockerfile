FROM debian:bullseye

# Install PHP-FPM, PHP extensions, curl, and mariadb-client
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-intl \
    php-mbstring \
    php-xml \
    php-zip \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI (WordPress Command Line Interface)
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Copy custom PHP-FPM pool configuration
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Copy setup script
COPY tools/wordpress_setup.sh /usr/local/bin/wordpress_setup.sh
RUN chmod +x /usr/local/bin/wordpress_setup.sh

# Expose PHP-FPM port
EXPOSE 9000

# Execute setup script
ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]
