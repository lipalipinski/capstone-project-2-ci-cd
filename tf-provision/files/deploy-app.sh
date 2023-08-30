#!/bin/bash

APP_TAG="$1"
ECR_REGISTRY_URL="$2"

aws ecr get-login-password --region eu-central-1 \
  | docker login --username AWS --password-stdin $ECR_REGISTRY_URL

# stop any containers
docker stop $(docker ps -aq)

docker run -d -e TZ=UTC -p 80:80 jlipinski-petclinic:$APP_TAG