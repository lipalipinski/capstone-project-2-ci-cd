#!/bin/bash

APP_TAG="$1"
ECR_REGISTRY_URL="$2"

echo -e "\nLoging to ECR..."
aws ecr get-login-password --region eu-central-1 \
  | docker login --username AWS --password-stdin $ECR_REGISTRY_URL

# stop any containers
echo -e "\nStopping any running containers..."
docker stop $(docker ps -aq)

# pull app image
echo -e "\nPulling $ECR_REGISTRY_URL:$APP_TAG\..."
docker pull -q $ECR_REGISTRY_URL:$APP_TAG


echo -e "\nRunning $ECR_REGISTRY_URL:$APP_TAG\..."
docker run -d -p 80:8080 $ECR_REGISTRY_URL:$APP_TAG