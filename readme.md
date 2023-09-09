# DevOps Internship Capstone Project
Whole project consists of three repositories:
- [Pre-setup repository ](https://github.com/lipalipinski/capstone-project-2-pre-setup)
- Continous Integration repository (this repository)
- [Petclinic application repository](https://github.com/lipalipinski/spring-petclinic)

# CICD Repository

This repository contains Jenkinsfiles, Terraform plan and other resources for jobs that provision application infrastructure, build app container image and deploy it on server.

## Jobs

### Petclinic-Provision-Plan
Allows to verify execution plans before provisioning application infrastructure

### Petclinic-Provision-Up
Provisions an RDS DB instance, ALB and an EC2 instance for a Petclinic application.
If the RDS already exiists, but is not available (i.e. stopped) it tries to start it 
and wait for it to become available. After provisioning an application EC2 instance it runs Apache2 
container and exposes it on :8080 to tests a connection and validate server configuration.

### Petclinic-Provision-Down
Destroys application ALB and EC2. Optionally it could stop and/or destrooy application DB.
After stopping a DB waits for its state to become "stopped".

### Petclinic-CI
Continous Integration pipeline triggered by GitHub webhook.
Tests app on push, builds a container and stores container image in ECR.
Image tag is short commit hash, or app version (when building a commit to main branch)
Validates app version on pull request. Tags a commit on main branch with application version.

### Petclinic-Deploy
Deploy an application container with a given tag.
Takes a server IP from terraform output.
Takes SSH key from credentials (provided with Secrets Manager plugin)
Takes ECR_REGISTRY_URL from AWS Parameter Store.
Tests the application on ALB address.

