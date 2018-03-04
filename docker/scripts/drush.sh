#!/usr/bin/env bash

# Download latest stable release using the code below or browse to github.com/drush-ops/drush/releases.
php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush
# Or use our upcoming release: php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush-unstable.phar');" > drush

# Test your install.
php drush core-status

# Make `drush` executable as a command from anywhere. Destination can be anywhere on $PATH.
chmod +x drush
mv drush /usr/local/bin

# Optional. Enrich the bash startup file with completion and aliases.
drush init -y


#FIX a bug where drush does not add a newline between the comment and if statement
# that it appends to .bashrc
#CHANGES FROM
# Include Drush prompt customizations.if [ -f "/root/.drush/drush.prompt.sh" ]
#TO
# Include Drush prompt customizations.
# if [ -f "/root/.drush/drush.prompt.sh" ]
sed 's/customizations.if/customizations\nif/g' < ~/.bashrc > ~/.bashrc1 && mv ~/.bashrc1 ~/.bashrc