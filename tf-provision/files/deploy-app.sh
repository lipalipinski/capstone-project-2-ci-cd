#!/bin/bash

APP_TAG="$1"

# stop any containers
docker stop $(docker ps -aq)

docker run -d -e TZ=UTC -p 80:80 jlipinski-petclinic:$APP_TAG