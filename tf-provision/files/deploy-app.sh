#!/bin/bash

APP_TAG="$1"
ECR_REGISTRY_URL="$2"
DB_PASS_ARN="$3"
DB_URL="$4"

# get db password from secrets manager
DB_PASS=$(aws secretsmanager get-secret-value \
  --output text \
  --query "SecretString" \
  --secret-id "$DB_PASS_ARN" \
    | jq -r ".password")

# get db username
DB_USER=$(aws secretsmanager get-secret-value \
  --output text \
  --query "SecretString" \
  --secret-id "$DB_PASS_ARN" \
    | jq -r ".username")

# log to ECR
echo -e "\nLoging to ECR..."
aws ecr get-login-password --region eu-central-1 \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY_URL"

# stop any running containers
echo -e "\nStopping any running containers..."
docker stop $(docker ps -aq)

# pull app image
echo -e "\nPulling $ECR_REGISTRY_URL:$APP_TAG\..."
docker pull -q "$ECR_REGISTRY_URL:$APP_TAG"

# run app container
echo -e "\nRunning $ECR_REGISTRY_URL:$APP_TAG\..."
docker run -d \
  -p 80:8080 \
  -e SPRING_PROFILES_ACTIVE=mysql \
  -e MYSQL_URL="jdbc:mysql://$DB_URL/petclinic" \
  -e MYSQL_USER="$DB_USER" \
  -e MYSQL_PASS="$DB_PASS" \
  "$ECR_REGISTRY_URL:$APP_TAG"