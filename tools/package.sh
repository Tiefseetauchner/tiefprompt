#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

REPO_DIR=$(dirname "$0")/..
KEY_STORE=$REPO_DIR/keys/
PACKAGE_DIR=$REPO_DIR/package/
CURRENT_DOCKER_VERSION_FILE="tools/docker_container_current_version.txt"
CURRENT_DOCKER_VERSION=$(cat "${CURRENT_DOCKER_VERSION_FILE}")
DOCKER_IMAGE="tiefseetauchner/tiefprompt-build:$CURRENT_DOCKER_VERSION"
CONTAINER_NAME="tiefprompt_build_container"
TARGETS="androidaab,androidapk"
FREEDOM="foss,freemium"

# Graceful shutdown
exitfn() {
  error_echo "${RED}Caught SIGINT. Stopping Docker container...${NC}" "YES"
  trap - SIGINT
  verbose_echo "${YELLOW}Stopping Docker container with name: $CONTAINER_NAME${NC}"
  docker stop $CONTAINER_NAME 2>/dev/null
  exit 1
}

trap "exitfn" INT

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
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

  case $opt in
    f)
      FREEDOM="$OPTARG"
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
  -e VERBOSE=$VERBOSE\
  -e MORE_VERBOSE=$MORE_VERBOSE\
  --name $CONTAINER_NAME \
  $DOCKER_IMAGE

EXIT_CODE=$?
if [ $EXIT_CODE -eq 0 ]; then
  normal_echo "${GREEN}Build completed successfully. Packages available in: $PACKAGE_DIR${NC}"
else
  error_echo "${RED}Build failed.${NC}" "NO" $EXIT_CODE
fi
