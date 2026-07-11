#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

info() {
  echo -e "${GREEN}Run Screenshot Tests for Android Emulators${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: screenshots.sh [options]${NC}

EOF

  help_common_params
}

while getopts "${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi
  
  case "$opt" in
    \?)
      error_echo "Unknown option: -$opt" "NO" 1
      usage
      exit 1
      ;;
  esac
done

script_exitfn() {
  disable_iap
  stop_screenshot_server
}

script_intfn() {
  stop_emulator
}

declare -a emulators=("7intablet" "10intablet" "16by9phone")

enable_iap
start_screenshot_server

for emulator in "${emulators[@]}"; do
  CURRENT_EMULATOR="$emulator"
  start_emulator "$CURRENT_EMULATOR"
  run_tests integration_test/screenshot_automation_test.dart emulator
  stop_emulator
  sleep 5
  normal_echo "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"
done

normal_echo "${GREEN}All tests completed on all emulators.${NC}"