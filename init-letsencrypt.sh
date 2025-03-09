#!/bin/bash

# This script will automatically set up SSL certificates using Let's Encrypt
# Based on https://github.com/wmnnd/nginx-certbot

# Change these variables:
domains=(sdc.janharkonen.fi)  # Your domains
email="jan.harkonen@pionblanc.fi"  # Your email for Let's Encrypt notices
staging=1  # Set to 1 for testing, 0 for production

# Create required directories
mkdir -p ./nginx/certbot/conf
mkdir -p ./nginx/certbot/www
mkdir -p ./nginx/conf
mkdir -p ./nginx/logs

# Copy nginx config file if it doesn't exist
if [ ! -f ./nginx/conf/app.conf ]; then
  echo "NGINX config file not found. Please create ./nginx/conf/app.conf first."
  exit 1
fi

# Create dummy certificates (for initial startup)
domain_path="./nginx/certbot/conf/live/${domains[0]}"
if [ ! -d "$domain_path" ]; then
  echo "Creating dummy certificates..."
  mkdir -p "$domain_path"
  openssl req -x509 -nodes -newkey rsa:4096 -days 1 \
    -keyout "$domain_path/privkey.pem" \
    -out "$domain_path/fullchain.pem" \
    -subj "/CN=localhost"
fi

# Start nginx
echo "Starting nginx..."
docker-compose up -d nginx

# Sleep to ensure nginx is up and running
sleep 5

# Request real certificates
echo "Requesting Let's Encrypt certificates..."
# Join domains for certbot command
domain_args=""
for domain in "${domains[@]}"; do
  domain_args="$domain_args -d $domain"
done

# Select appropriate certbot command based on staging setting
if [ $staging != "0" ]; then
  staging_arg="--staging"
else
  staging_arg=""
fi

# Run certbot with explicit command instead of using the entrypoint from docker-compose
docker-compose run --rm \
  --entrypoint certbot \
  certbot \
  certonly --webroot \
  --webroot-path=/var/www/certbot \
  $staging_arg \
  --email $email \
  --agree-tos \
  --no-eff-email \
  $domain_args

# Reload nginx
echo "Reloading nginx..."
docker-compose exec nginx nginx -s reload

echo "Setup completed!"
