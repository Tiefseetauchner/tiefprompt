#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

info() {
  echo -e "${GREEN}Enable In-App Purchases${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: enable_iap.sh [options]${NC}
EOF

  help_common_params
}

while getopts "${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi
done

enable_iap