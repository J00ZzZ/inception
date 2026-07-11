#!/bin/bash
set -e

# Create SSL directory if not exists
mkdir -p /etc/nginx/ssl

# Generate self-signed certificate if it doesn't exist
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Creating SSL self-signed certificate for ${DOMAIN_NAME}..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=liyu-her/CN=${DOMAIN_NAME}"
fi

echo "Nginx setup completed. Starting Nginx..."
exec nginx -g "daemon off;"
