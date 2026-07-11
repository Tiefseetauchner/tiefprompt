#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/../common.sh"

info() {
  echo -e "${GREEN}Compose Marketing Screenshots into Titlebar'd, Shadowed Collages${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: compose.sh [options]${NC}

${GREEN}-r substring${NC}Only render collages whose output filename contains this substring.
${GREEN}-i dir      ${NC}Input directory containing screenshots to compose. Defaults to screenshots/Marketing.
${GREEN}-o dir      ${NC}Output directory for composed collages. Defaults to screenshots/Marketing/composed.
EOF

  help_common_params
}

COMPOSE_DIR="tools/marketing_screenshots/marketing_compose"
SCREENSHOTS_DIR="screenshots/Marketing"

while getopts "r:i:o:${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

  case $opt in
    r)
      ONLY=$OPTARG
      ;;
    i)
      SCREENSHOTS_DIR=$OPTARG
      ;;
    o)
      OUTPUT_DIR=$OPTARG
      ;;
    \?)
      echo "Use -h for help"
      exit 1
      ;;
  esac
done

compose_args=(--input-dir "$SCREENSHOTS_DIR" --output-dir "${OUTPUT_DIR:-$SCREENSHOTS_DIR/composed}")
if [ -n "$ONLY" ]; then
  compose_args+=(--only "$ONLY")
fi

normal_echo "${CYAN}Composing marketing screenshots...${NC}"

uv run --project "$COMPOSE_DIR" "$COMPOSE_DIR/main.py" "${compose_args[@]}" \
  > >(verbose_echo_stdin "compose") \
  2> >(error_echo_stderr "compose")

normal_echo "${GREEN}Finished composing marketing screenshots.${NC}"
