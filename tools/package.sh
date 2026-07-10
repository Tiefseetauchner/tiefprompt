#!/bin/bash

source tools/common.sh

REPO_DIR=$(dirname "$0")/..
KEY_STORE=$REPO_DIR/keys/
PACKAGE_DIR=$REPO_DIR/package/
DOCKER_IMAGE="tiefseetauchner/tiefprompt-build:latest"
CONTAINER_NAME="tiefprompt_build_container"
TARGETS="androidaab,androidapk"
FREEDOM="foss,freemium"

info() {
  echo -e "${GREEN}Package TiefPrompt for Android in Docker Container${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: package.sh [options]${NC}

${GREEN}-f freedom  ${NC}Comma separated list of freedoms. Options:
            freemium,foss
            ${RED}(!) Required${NC}
EOF
  
  help_common_params
}

while getopts "f:$COMMON_PARAMS" opt; do
  case $opt in
    f)
      FREEDOM="$OPTARG"
      ;;
    h)
      info
      exit 0
      ;;
    \?)
      echo "Use -h for help"
      exit 1
      ;;
  esac
done

FREEDOM_LIST=$(echo "$FREEDOM" | tr ',' ' ')

# Ensure package directory exists
verbose_echo "${CYAN}Creating package directory: $PACKAGE_DIR${NC}"
mkdir -p "$PACKAGE_DIR"
rm -rf "$PACKAGE_DIR"/*
for freedom in $FREEDOM_LIST; do
  mkdir -p "$PACKAGE_DIR/$freedom"
  more_verbose_echo "${CYAN}Created directory for freedom: $freedom${NC}"
done
more_verbose_echo "${CYAN}Changing permissions for package directory: $PACKAGE_DIR${NC}"
chmod 777 -R "$PACKAGE_DIR"

docker pull $DOCKER_IMAGE

normal_echo "${YELLOW}Starting build in Docker container...${NC}"
docker run --rm \
  -v "$REPO_DIR:/app" \
  -v "$PACKAGE_DIR:/package" \
  -v "$KEY_STORE:/keys" \
  -e TARGETS=$TARGETS\
  -e FREEDOM=$FREEDOM\
  --name $CONTAINER_NAME \
  $DOCKER_IMAGE

if [ $? -eq 0 ]; then
  normal_echo "${GREEN}Build completed successfully. Packages available in: $PACKAGE_DIR${NC}"
else
  error_echo "${RED}Build failed.${NC}"
fi
