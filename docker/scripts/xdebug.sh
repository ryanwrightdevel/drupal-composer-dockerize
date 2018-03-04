#!/usr/bin/env bash
if [ "$XDEBUG" == "on" ]; then
    #DOCKER_REMPOTE_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
    #echo "xdebug.remote_host=${DOCKER_REMPOTE_IP}" > /usr/local/etc/php/conf.d/xdebug-remote-ip.ini

    #XDEBUG_REMOTE_IP will be passed to the container as an environment variable
    echo "xdebug.remote_host=${XDEBUG_REMOTE_IP}" > /usr/local/etc/php/conf.d/xdebug-remote-ip.ini
else

    if [ -f '/usr/local/etc/php/conf.d/xdebug-remote-ip.ini' ]; then
        rm /usr/local/etc/php/conf.d/xdebug-remote-ip.ini
    fi
fi