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
  cp app.conf ./nginx/conf/
fi

# Create dummy certificates (for initial startup)
if [ ! -d "./nginx/certbot/conf/live/$domains" ]; then
  echo "Creating dummy certificates..."
  mkdir -p "./nginx/certbot/conf/live/$domains"
  openssl req -x509 -nodes -newkey rsa:4096 -days 1 \
    -keyout "./nginx/certbot/conf/live/$domains/privkey.pem" \
    -out "./nginx/certbot/conf/live/$domains/fullchain.pem" \
    -subj "/CN=localhost"
fi

# Start nginx
echo "Starting nginx..."
docker-compose up -d nginx

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

docker-compose run --rm certbot certonly --webroot -w /var/www/certbot \
  $staging_arg \
  --email $email \
  --agree-tos \
  --no-eff-email \
  $domain_args

# Reload nginx
echo "Reloading nginx..."
docker-compose exec nginx nginx -s reload

echo "Setup completed!"
