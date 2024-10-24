#!/bin/bash

# chmod +x example.bash
# ./example.bash docker.io/nginx:latest

DOCKER_IMAGE_NAME=$1

docker pull ${DOCKER_IMAGE_NAME}

docker run --rm ghcr.io/rootshell-coder/trivy-cached:latest image ${DOCKER_IMAGE_NAME} --skip-db-update > ./example.report.txt
