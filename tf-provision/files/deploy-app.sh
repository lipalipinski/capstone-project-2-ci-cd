#!/bin/bash

# stop any containers
docker stop $(docker ps -aq)

docker run -d --name apache2-container -e TZ=UTC -p 80:80 ubuntu/apache2:2.4-22.04_beta