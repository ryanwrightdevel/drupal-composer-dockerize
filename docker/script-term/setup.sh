#!/usr/bin/env bash

docker-compose up -d --build

php getdrupal

docker-compose exec drupalweb /var/www/install-scripts/install-drupal.sh