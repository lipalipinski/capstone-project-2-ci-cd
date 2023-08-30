#!/bin/bash

APP_TAG="$1"
ECR_REGISTRY_URL="$2"

aws ecr get-login-password --region eu-central-1 \
  | docker login --username AWS --password-stdin $ECR_REGISTRY_URL

# stop any containers
docker stop $(docker ps -aq)

docker run -d -p 80:8080 $ECR_REGISTRY_URL:$APP_TAG