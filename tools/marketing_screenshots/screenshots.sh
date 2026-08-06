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

${GREEN}-e          ${NC}Comma-separated list of fixtures to run tests on.
            Supported fixtures: ${YELLOW}MarketingTablet, MarketingWideTablet, MarketingTabletFreemium${NC}
${GREEN}-t          ${NC}Comma-separated list of harness names to run tests on.
EOF

  help_common_params
}

unset -v REQUESTED_FIXTURES_NAMES
unset -v HARNESS_NAMES

while getopts "e:t:${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

  case "$opt" in
    e)
      REQUESTED_FIXTURES_NAMES="$(echo "$OPTARG" | tr ',' ' ')"
      ;;
    t)
      HARNESS_NAMES="$OPTARG"
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
  "MarketingTablet MarketingTablet integration_test/marketing/marketing_tablet_test.dart foss"
  "MarketingWideTablet MarketingWideTablet integration_test/marketing/marketing_wide_tablet_test.dart foss"
  "MarketingTabletFreemium MarketingTablet integration_test/marketing/marketing_tablet_freemium_test.dart freemium"
)

start_screenshot_server

for ENTRY in "${EMULATOR_TEST_FILES[@]}"; do
  read -r FIXTURE_NAME CURRENT_EMULATOR TEST_FILE VARIANT <<< "$ENTRY"

  if [[ -n "$REQUESTED_FIXTURES_NAMES" ]] && [[ ! " $REQUESTED_FIXTURES_NAMES " == *" $FIXTURE_NAME "* ]]; then
    continue
  fi

  if [[ "$VARIANT" == "freemium" ]]; then
    enable_iap
  fi

  start_emulator "$CURRENT_EMULATOR"
  normal_echo "${GREEN}Running marketing scenarios of fixture $FIXTURE_NAME on emulator: $CURRENT_EMULATOR${NC}"
  run_tests "$TEST_FILE" "emulator" "$HARNESS_NAMES"
  stop_emulator
  sleep 5
  normal_echo "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"

  if [[ "$VARIANT" == "freemium" ]]; then
    disable_iap
  fi
done

normal_echo "${GREEN}All tests completed on all emulators.${NC}"
