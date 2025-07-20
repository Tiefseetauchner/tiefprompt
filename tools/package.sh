#!/bin/bash

KEY_STORE="/run/media/veracrypt1/"
REPO_DIR=$(dirname "$0")/..
PACKAGE_DIR=$REPO_DIR/package/
DOCKER_IMAGE="tiefprompt-build"
CONTAINER_NAME="tiefprompt_build_container"

# Define colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# Ensure package directory exists
echo -e "${CYAN}Creating package directory: $PACKAGE_DIR${RESET}"
mkdir -p "$PACKAGE_DIR"
rm -rf "$PACKAGE_DIR"/*

# Build the Docker container if it doesn't exist
#if ! docker image inspect $DOCKER_IMAGE >/dev/null 2>&1; then
  echo -e "${YELLOW}Building Docker image...${RESET}"
  docker build -t $DOCKER_IMAGE -f tools/Dockerfile .
#fi

# Run the build script inside Docker
echo -e "${YELLOW}Starting build in Docker container...${RESET}"
docker run --rm \
  -v "$REPO_DIR:/app" \
  -v "$PACKAGE_DIR:/app/package" \
  -v "$KEY_STORE:/keys" \
  --name $CONTAINER_NAME \
  $DOCKER_IMAGE

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Build completed successfully. Packages available in: $PACKAGE_DIR${RESET}"
else
  echo -e "${RED}Build failed.${RESET}"
  exit 1
fi
