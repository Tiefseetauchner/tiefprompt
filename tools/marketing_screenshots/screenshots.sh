#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/../common.sh"

info() {
  echo -e "${GREEN}Run Screenshot Tests for Android Emulators${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: screenshots.sh [options]${NC}

${GREEN}-e          ${NC}Comma-separated list of emulator names to run tests on.
EOF

  help_common_params
}

unset -v EMULATOR_NAMES

while getopts "e:${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

  case "$opt" in
    e)
      EMULATOR_NAMES="$(echo "$OPTARG" | tr ',' ' ')"
      ;;
    \?)
      error_echo "Unknown option: -$opt" "NO" 1
      usage
      exit 1
      ;;
  esac
done

script_exitfn() {
  stop_screenshot_server
}

script_intfn() {
  stop_emulator
}

# One aggregator test file per emulator: every harness targeting that
# emulator is registered into a single main(), so `flutter test` only has
# to build and install the app once per emulator instead of once per screen.
EMULATOR_TEST_FILES=(
  "MarketingTablet integration_test/marketing/marketing_tablet_test.dart"
  "MarketingWideTablet integration_test/marketing/marketing_wide_tablet_test.dart"
)

start_screenshot_server

for ENTRY in "${EMULATOR_TEST_FILES[@]}"; do
  read -r CURRENT_EMULATOR TEST_FILE <<< "$ENTRY"

  if [[ -n "$EMULATOR_NAMES" ]] && [[ ! " $EMULATOR_NAMES " == *" $CURRENT_EMULATOR "* ]]; then
    continue
  fi

  start_emulator "$CURRENT_EMULATOR"
  normal_echo "${GREEN}Running marketing scenarios on emulator: $CURRENT_EMULATOR${NC}"
  run_tests "$TEST_FILE" "emulator"
  stop_emulator
  sleep 5
  normal_echo "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"
done

normal_echo "${GREEN}All tests completed on all emulators.${NC}"
