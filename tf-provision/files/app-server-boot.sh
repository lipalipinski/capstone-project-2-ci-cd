#!/bin/bash

# run Apache server to test the connection
docker run -d -e TZ=UTC -p 8080:80 ubuntu/apache2:2.4-22.04_beta