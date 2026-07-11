#!/bin/zsh

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

info() {
  echo -e "${GREEN}Run Screenshot Tests for iOS Simulators${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: screenshots_ios.sh [options]${NC}

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

# Declare arrays
simulators=("iPhone-6-9" "iPhone-6-5" "iPad-13")
typeset -A simulator_udids

script_exitfn() {
  stop_simulators
  stop_screenshot_server
  disable_iap
}

get_simulator_udids

for simulator in "${simulators[@]}"; do
  CURRENT_SIMULATOR="$simulator"
  start_screenshot_server
  start_simulator "$CURRENT_SIMULATOR"
  run_tests integration_test/screenshot_automation_test.dart simulator
  stop_simulators
  sleep 5
  stop_screenshot_server
  normal_echo "${GREEN}Finished tests on $CURRENT_SIMULATOR${NC}"
  echo
done

normal_echo "${GREEN}All tests completed on all simulators.${NC}"
