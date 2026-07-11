FROM debian:bullseye

# Install Nginx and OpenSSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Clean up default configurations
RUN rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default

# Copy custom configuration
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Copy script and set execution permissions
COPY tools/nginx_setup.sh /usr/local/bin/nginx_setup.sh
RUN chmod +x /usr/local/bin/nginx_setup.sh

# Expose only SSL port
EXPOSE 443

# Execute setup script
ENTRYPOINT ["/usr/local/bin/nginx_setup.sh"]
