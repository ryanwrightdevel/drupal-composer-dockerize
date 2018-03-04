#!/usr/bin/env bash
docker-compose stop
docker-compose rm -fv
rm -fr docker/volume-data
rm -fr html