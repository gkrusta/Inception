#!/bin/sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out c \
-subj "/C=Malaga/L=Malaga/O=42/OU=student/CN=gkrusta"

nginx -g "daemon off;"