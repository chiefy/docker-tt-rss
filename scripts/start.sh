#!/bin/sh

while ! nc -z db 5432 2>/dev/null; do
  echo "Waiting for postgres on 5432..."
  sleep 1
done

./create-schema && php-fpm7 -F
