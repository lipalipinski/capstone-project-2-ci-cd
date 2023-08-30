#!/bin/bash

APP_TAG="$1"
ECR_REGISTRY_URL="$2"

echo "Loging to ECR..."
aws ecr get-login-password --region eu-central-1 \
  | docker login --username AWS --password-stdin $ECR_REGISTRY_URL

# stop any containers
echo "Stopping any running containers..."
docker stop $(docker ps -aq)

# pull app image
echo "Pulling $ECR_REGISTRY_URL:$APP_TAG\..."
docker pull -q $ECR_REGISTRY_URL:$APP_TAG

echo "Running $ECR_REGISTRY_URL:$APP_TAG\..."
docker run -d -p 80:8080 $ECR_REGISTRY_URL:$APP_TAG