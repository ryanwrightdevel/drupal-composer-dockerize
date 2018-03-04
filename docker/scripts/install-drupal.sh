#!/usr/bin/env bash

source /var/www/install-scripts/env.sh

cd /var/www/html/web

echo -e "Preparing to install drupal: "
echo -e "DATABASE NAME: ${DB_NAME} "
echo -e "DATABASE USER: ${DB_USER} "
echo -e "DATABASE PASS: ${DB_PASS} "
echo -e "DATABASE HOST: ${DB_HOST} "
echo -e "SITE NAME: ${DRUPAL_SITE_NAME}"


drush site-install -y standard --db-url="mysql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME}" \
      --site-name=${DRUPAL_SITE_NAME} \
      --account-name=admin --account-pass=admin


