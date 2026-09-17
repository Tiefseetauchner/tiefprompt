#!/usr/bin/env bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

DOCKER_IMAGE_NAME="tiefseetauchner/tiefprompt-build"
DOCKERFILE="tools/Dockerfile"
CURRENT_DOCKER_VERSION_FILE="tools/docker_container_current_version.txt"

info() {
  echo -e "${GREEN}Build and publish the TiefPrompt build container${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: docker_publish.sh (-m | -M) [options]${NC}

${GREEN}-m          ${NC}Bump the minor version (X.Y -> X.(Y+1)).
            ${RED}(!) Required, mutually exclusive with -M${NC}
${GREEN}-M          ${NC}Bump the major version (X.Y -> (X+1).0).
            ${RED}(!) Required, mutually exclusive with -m${NC}
${GREEN}-d          ${NC}Dry run. Build and tag locally, but don't push.
${GREEN}-c          ${NC}Build the Docker image without using cache.
${GREEN}-p          ${NC}Plain progress output (no TTY animation).
EOF

  help_common_params
}

BUMP=""
DRY_RUN=""
NO_CACHE=""
PLAIN_PROGRESS=""

while getopts "mMdcp${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "${OPTARG}"
    continue
  fi

  case $opt in
    m)
      [ -z "$BUMP" ] || error_echo "-m and -M are mutually exclusive." "NO" 1
      BUMP="minor"
      ;;
    M)
      [ -z "$BUMP" ] || error_echo "-m and -M are mutually exclusive." "NO" 1
      BUMP="major"
      ;;
    d)
      DRY_RUN="YES"
      ;;
    c)
      NO_CACHE="YES"
      ;;
    p)
      PLAIN_PROGRESS="YES"
      ;;
    \?)
      echo "Use -h for help"
      exit 1
      ;;
    *)
      error_echo "Unknown option: -$opt" "NO" 1
      usage
      exit 1
      ;;
  esac
done

[ -n "$BUMP" ] || error_echo "One of -m (minor) or -M (major) is required." "NO" 1

verbose_echo "${BLUE}Fetching published tags for $DOCKER_IMAGE_NAME...${NC}"
tags_json=$(curl -sf "https://hub.docker.com/v2/repositories/${DOCKER_IMAGE_NAME}/tags?page_size=100") \
  || error_echo "Failed to fetch tags from Docker Hub." "NO" 1

current_version=$(echo "$tags_json" | jq -r '.results[].name' | grep -E '^[0-9]+\.[0-9]+$' | sort -V | tail -n1)
[ -n "$current_version" ] || error_echo "Could not find an existing X.Y version tag for $DOCKER_IMAGE_NAME." "NO" 1
verbose_echo "${CYAN}Current published version: $current_version${NC}"

major="${current_version%%.*}"
minor="${current_version#*.}"

if [ "$BUMP" = "major" ]; then
  new_version="$((major + 1)).0"
else
  new_version="${major}.$((minor + 1))"
fi

echo "$tags_json" | jq -e --arg v "$new_version" '.results[] | select(.name == $v)' > /dev/null \
  && error_echo "Tag '$new_version' already exists on Docker Hub. Refusing to overwrite." "NO" 1

normal_echo "${GREEN}Bumping $current_version -> $new_version ($BUMP)${NC}"

verbose_echo "${BLUE}Building $DOCKER_IMAGE_NAME:$new_version...${NC}"
docker build \
  -f "$DOCKERFILE" \
  -t "$DOCKER_IMAGE_NAME:$new_version" \
  -t "$DOCKER_IMAGE_NAME:latest" \
  ${NO_CACHE:+--no-cache} \
  ${PLAIN_PROGRESS:+--progress=plain} \
  .

if [ -n "$DRY_RUN" ]; then
  normal_echo "${YELLOW}Dry run: skipping push of $DOCKER_IMAGE_NAME:$new_version and :latest.${NC}"
  exit 0
fi

verbose_echo "${BLUE}Pushing $DOCKER_IMAGE_NAME:$new_version...${NC}"
docker push \
  ${PLAIN_PROGRESS:+--progress=plain} \
  "$DOCKER_IMAGE_NAME:$new_version"

verbose_echo "${BLUE}Pushing $DOCKER_IMAGE_NAME:latest...${NC}"
docker push \
  ${PLAIN_PROGRESS:+--progress=plain} \
  "$DOCKER_IMAGE_NAME:latest"

verbose_echo "${BLUE}Setting version in $CURRENT_DOCKER_VERSION_FILE to $new_version...${NC}"
echo "$new_version" > "$CURRENT_DOCKER_VERSION_FILE"

normal_echo "${GREEN}Published $DOCKER_IMAGE_NAME:$new_version and updated :latest.${NC}"
