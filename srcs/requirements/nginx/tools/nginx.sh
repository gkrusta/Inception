#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:1024 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=MA/L=MA/O=42/OU=student/CN=gkrusta"
tail -f
nginx -g "daemon off;"