FROM php:7.1.1-apache
MAINTAINER ryanwrightny@gmail.comm
COPY docker/scripts/ /var/www/install-scripts/
COPY docker/conf/apache-conf /etc/apache2/sites-available
COPY docker/conf/php-conf/php-custom.ini /usr/local/etc/php/conf.d/php-custom.ini
COPY docker/conf/php-conf/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#store root password for mariadb(mysql)
ENV MYSQLTMPROOT root
ENV DEBIAN_FRONTEND noninteractive


# Install GD
RUN apt-get update \

    #create a directory for storing logs
    && mkdir /var/www/log  \

    #folder to storm profiling data from xdebug
    && mkdir -p /var/www/xdebug/cachegrind  \

    #folder to storm trace data from xdebug
    && mkdir -p /var/www/xdebug/trace  \

    && apt-get install -y vim wget git \

        # create another subdirectory that will become the apache root
    && mkdir -p /var/www/html/web \

    #enable mod-rewrite
    && a2enmod rewrite \

    #install the GD php extension
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \

    #install xdebug
    && pecl install xdebug-2.5.3 \
    && XDEBUG_SO=$(find / -name '*xdebug.so') && echo "zend_extension=${XDEBUG_SO}" \
       > /usr/local/etc/php/conf.d/xdebug_so.ini \


    #install MCRYPT php extension
    && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install mcrypt \

    #install OPCACHE php extension
    && docker-php-ext-install opcache iconv mbstring  \

    #install ICONV php extension
    && docker-php-ext-install iconv  \

    #install MBSTRING php extension
    && docker-php-ext-install mbstring \

    #install PDO and PDO_MYSQL extension
    && docker-php-ext-install pdo pdo_mysql \


    #install mariadb(mysql) non-inactively. Drush will need mysql to make sql connections
    && echo mysql-server mysql-server/root_password password $MYSQLTMPROOT | debconf-set-selections \
    && echo mysql-server mysql-server/root_password_again password $MYSQLTMPROOT | debconf-set-selections  \
    && apt-get install -y mariadb-server-10.0 \

    #install composer
    && chmod +x /var/www/install-scripts/composer.sh  \
    && /var/www/install-scripts/./composer.sh \

    #install install drush
    && chmod +x /var/www/install-scripts/drush.sh \
    && /var/www/install-scripts/./drush.sh \

    #make install-drupal.sh execute but do not run it
    && chmod +x /var/www/install-scripts/install-drupal.sh \

    && cp /usr/local/bin/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint2 \
    #we want our boot.sh file to run everytime the container boots

    #this script will determine the remote host ip(YOUR COMPUTER) of the xdebug client
    #create a .ini for for php to load
    && chmod +x /var/www/install-scripts/xdebug.sh \

    #we'll use sed to add boot.sh to the entrypoint file so that it runs on each boot.
    && chmod +x /var/www/install-scripts/./boot.sh \
    && sed  "s/set -e/set -e\n\/var\/www\/install-scripts\/.\/boot.sh/g" \
    < /usr/local/bin/docker-php-entrypoint > /usr/local/bin/docker-php-entrypoint2 \
    && mv /usr/local/bin/docker-php-entrypoint2 /usr/local/bin/docker-php-entrypoint