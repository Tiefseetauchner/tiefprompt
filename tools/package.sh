#!/bin/bash

REPO_DIR=$(dirname "$0")/..
KEY_STORE=$REPO_DIR/keys/
PACKAGE_DIR=$REPO_DIR/package/
DOCKER_IMAGE="tiefseetauchner/tiefprompt-build:latest"
CONTAINER_NAME="tiefprompt_build_container"
TARGETS="androidaab,androidapk"

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
mkdir -p "$PACKAGE_DIR/foss"
mkdir -p "$PACKAGE_DIR/freemium"
chmod 777 -R $PACKAGE_DIR

docker pull $DOCKER_IMAGE

echo -e "${YELLOW}Starting build for foss in Docker container...${RESET}"
docker run --rm \
  -v "$REPO_DIR:/app" \
  -v "$PACKAGE_DIR/foss:/package" \
  -v "$KEY_STORE:/keys" \
  -e TARGETS=$TARGETS\
  -e FREEDOM=foss\
  --name $CONTAINER_NAME \
  $DOCKER_IMAGE

echo -e "${YELLOW}Starting build for foss in Docker container...${RESET}"
docker run --rm \
  -v "$REPO_DIR:/app" \
  -v "$PACKAGE_DIR/freemium:/package" \
  -v "$KEY_STORE:/keys" \
  -e TARGETS=$TARGETS\
  -e FREEDOM=freemium\
  --name $CONTAINER_NAME \
  $DOCKER_IMAGE

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Build completed successfully. Packages available in: $PACKAGE_DIR${RESET}"
else
  echo -e "${RED}Build failed.${RESET}"
  exit 1
fi
