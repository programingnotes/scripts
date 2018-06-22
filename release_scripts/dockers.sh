#!/bin/bash

WHITE="\033[1;37m"
CYAN="\033[1;36m"

DOCKER_BUILD="${CYAN}❯ Rebuilding Docker Image"
DOCKER_TAG="${CYAN}❯ Tagging Docker Image"
DOCKER_PUSH="${CYAN}❯ Pushing Docker Image"
USERNAME=nonni
IMAGE=ruby-2.5.1

echo -e "$DOCKER_BUILD"
docker build -t "$USERNAME/$IMAGE" .
echo ""

# echo -e "DOCKER_TAG"
# docker tag "USERNAME/$IMAGE:latest"
# echo 

echo -e "$DOCKER_PUSH"
docker push "$USERNAME/$IMAGE:latest"
