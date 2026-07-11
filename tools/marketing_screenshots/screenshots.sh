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

${GREEN}-t          ${NC}Comma-separated list of test names to run. If not specified, all tests will be run.
${GREEN}-e          ${NC}Comma-separated list of emulator names to run tests on.
EOF

  help_common_params
}

unset -v TEST_NAMES
unset -v EMULATOR_NAMES

while getopts "t:e:${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

  case "$opt" in
    t)
      TEST_NAMES="$(echo "$OPTARG" | tr ',' ' ')"
      ;;
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

retrieve_emulator_test_combinations() {
  local -n emulator_defaults=$1
  local -n emulator_names=$2
  local -n test_names=$3

  if [[ -z "$emulator_names" && -z "$test_names" ]]; then
    EMULATORS=("${emulator_defaults[@]}")
    return
  fi

  if [[ -z "$emulator_names" ]]; then
    emulator_names=("${emulator_defaults[@]%% *}")
  fi

  if [[ -z "$test_names" ]]; then
    test_names=("${emulator_defaults[@]#* }")
  fi

  EMULATORS=()
  for emulator in "${emulator_names[@]}"; do
    for test in "${test_names[@]}"; do
      EMULATORS+=("$emulator $test")
    done
  done
}

EMULATOR_DEFAULTS=(
  "MarketingTablet home_screen select_script_screen settings_screens"
  "MarketingWideTablet prompter_screen"
)

retrieve_emulator_test_combinations EMULATOR_DEFAULTS EMULATOR_NAMES TEST_NAMES

start_screenshot_server

for EMULATOR_GROUP in "${EMULATORS[@]}"; do
  IFS=' ' read -r -a EMULATOR_GROUP_ARRAY <<< "$EMULATOR_GROUP"
  CURRENT_EMULATOR="${EMULATOR_GROUP_ARRAY[0]}"
  start_emulator "$CURRENT_EMULATOR"
  for ((i=1; i<${#EMULATOR_GROUP_ARRAY[@]}; i++)); do
    SCREEN_NAME="${EMULATOR_GROUP_ARRAY[i]}"
    normal_echo "${GREEN}Running tests for screen: $SCREEN_NAME on emulator: $CURRENT_EMULATOR${NC}"
    run_tests "integration_test/marketing/$SCREEN_NAME" "emulator"
  done
  stop_emulator
  sleep 5
  normal_echo "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"
done

normal_echo "${GREEN}All tests completed on all emulators.${NC}"