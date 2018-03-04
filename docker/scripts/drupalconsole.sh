#!/usr/bin/env bash


#composer require drupal/console:@stable --prefer-dist --optimize-autoloader
#composer update drupal/console --with-dependencies
composer global require drupal/console:@stable
#echo "PATH=$PATH:~/.composer/vendor/bin" >> ~/.bashrc
#source ~/.bashrc
ln -s /root/.composer/vendor/bin/drupal /usr/local/bin/drupal
#ln -s /copper/.composer/vendor/bin/drupal /usr/local/bin/drupal


#drupal init --override
#drupal init --override --no-interaction
