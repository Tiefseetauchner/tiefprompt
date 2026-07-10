# ANSI color codes
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'
YELLOW=$'\033[0;33m'
BLUE=$'\033[0;34m'
NC=$'\033[0m' # No Color

unset -v QUIET
unset -v VERBOSE
unset -v MORE_VERBOSE

COMMON_PARAMS="qvVh"

parse_common_params() {
  case $1 in
    q)
      QUIET=YES
      ;;
    v)
      VERBOSE=YES
      ;;
    V)
      MORE_VERBOSE=YES
      ;;
    h)
      info
      exit 0
      ;;
  esac
}

help_common_params() {
  cat <<EOF
${GREEN}-q (*c)     ${NC}Make script quiet.
${GREEN}-v (*c)     ${NC}Make script verbose.
${GREEN}-V (*c)     ${NC}Make script extremely verbose (careful here!).
${GREEN}-h (*c)     ${NC}Show this help.
${BLUE}   (*c)     = common parameter, can be used in any script.
              may not take effect in all scripts, but will not cause an error.${NC}
EOF
}

normal_echo() {
  if [ -z "$QUIET" ]; then
    echo -e "$1"
  fi
}

error_echo() {
  SHOULD_CONTINUE=${2:-$CONTINUE_ON_FAIL}
  echo -e "${RED}ERROR: $1$NC" >&2
  if [ ! "$SHOULD_CONTINUE" = "YES" ]; then
    exit "${3:-1}"
  fi
}

normal_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    normal_echo "$GREEN$program_name:$NC $line"
  done
}

error_echo_stderr() {
  program_name="$1"
  while IFS= read -r line; do
    error_echo "$program_name: $NC $line" "YES"
  done
}

verbose_echo() {
  if [ "$VERBOSE" ] || [ "$MORE_VERBOSE" ]; then
    echo -e "$1"
  fi
}

verbose_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    verbose_echo "$GREEN$program_name:$NC $line"
  done
}

more_verbose_echo() {
  if [ "$MORE_VERBOSE" ]; then
    echo -e "$1"
  fi
}

more_verbose_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    more_verbose_echo "$GREEN$program_name:$NC $line"
  done
}

enable_iap() {
  if [ -f pubspec.yaml.iap_disabled ]; then
    verbose_echo "pubspec.yaml.iap_disabled backup already exists. Cannot enable in-app purchase."
    verbose_echo "To disable in-app purchase, run tools/disable_iap.sh first."
    error_echo "Aborting enable_iap." "NO" 1
  fi

  more_verbose_echo "${CYAN}Enabling in-app purchase in pubspec.yaml...${NC}"
  sed -i.iap_disabled 's/  # in_app_purchase/  in_app_purchase/g' pubspec.yaml
  more_verbose_echo "${CYAN}Getting dependencies after enabling in-app purchase...${NC}"
  .flutter/bin/flutter pub get > >(more_verbose_echo_stdin "flutter") 2> >(error_echo_stderr "flutter" >&2)
}

disable_iap() {
  if [ ! -f pubspec.yaml.iap_disabled ]; then
    verbose_echo "pubspec.yaml.iap_disabled backup not found. Cannot disable in-app purchase."
    verbose_echo "If this is unintentional, you can enable in-app purchases using tools/enable_iap.sh."
    normal_echo "${YELLOW} Continuing without disabling in-app purchase. This could be an error state, or a failing script.${NC}"
    return
  fi

  more_verbose_echo "${CYAN}Disabling in-app purchase in pubspec.yaml...${NC}"
  mv pubspec.yaml.iap_disabled pubspec.yaml
  more_verbose_echo "${CYAN}Getting dependencies after disabling in-app purchase...${NC}"
  .flutter/bin/flutter pub get > >(more_verbose_echo_stdin "flutter") 2> >(error_echo_stderr "flutter" >&2)
}

start_screenshot_server() {
  if [[ $(curl -s http://localhost:3824/health) != "true" ]]; then
    verbose_echo "${BLUE}Starting screenshot HTTP server for emulator: $CURRENT_EMULATOR${NC}"
    EMULATOR_NAME="$CURRENT_EMULATOR" .flutter/bin/dart integration_test/screenshot_server.dart \
      > >(verbose_echo_stdin "screenshot_server") \
      2> >(error_echo_stderr "screenshot_server (error)") &
    SERVER_PID=$!
  
    server_started=false
    while [[ "$server_started" != "true" ]]; do
      sleep 1
      server_started=$(curl -s http://localhost:3824/health)
      verbose_echo "${YELLOW}Waiting for start...${NC}"
    done
  fi

  if [[ $SERVER_PID == '' ]]; then
    normal_echo "${YELLOW}Server seems to be running from previous run. This could be intended. If not, kill it manually.${NC}"
    return
  fi

  verbose_echo "${GREEN}HTTP server started with PID: $SERVER_PID${NC}"
}

stop_screenshot_server() {
  verbose_echo "${YELLOW}Stopping screenshot HTTP server...${NC}"
  if [[ -z "$SERVER_PID" ]]; then
    normal_echo "${RED}Server seems to be running from previous run. Kill it manually if needed.${NC}"
    return
  fi
  kill $SERVER_PID 2>/dev/null
  unset SERVER_PID
}

start_emulator() {
  emulator_name=$1
  verbose_echo "${BLUE}Starting emulator: $emulator_name${NC}"
  emulator -avd "$emulator_name" -no-audio -no-window \
    > >(more_verbose_echo_stdin "emulator") \
    2> >(error_echo_stderr "emulator" >&2) &

  verbose_echo "${YELLOW}Waiting for $emulator_name to boot...${NC}"
  adb wait-for-device

  boot_completed=""
  while [[ $boot_completed != "1" ]]; do
    boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null)
    verbose_echo "${YELLOW}Waiting for $emulator_name to boot...${NC}"
    sleep 1
  done
  verbose_echo "${GREEN}$emulator_name is ready.${NC}"
}

stop_emulator() {
  verbose_echo "${YELLOW}Stopping all emulators...${NC}"
  adb emu kill -as
  sleep 5
}

run_tests() {
  if [ -z "$1" ]; then
    error_echo "${RED}No test file specified.${NC}" "NO" 1
  fi

  if [ -z "$2" ]; then
    error_echo "${RED}No device type specified (emulator or simulator).${NC}" "NO" 1
  fi

  SERVER_IP=10.0.2.2

  verbose_echo "${BLUE}SERVER_IP: $SERVER_IP${NC}"

  verbose_echo "${BLUE}Starting Flutter testing...${NC}"
  .flutter/bin/flutter test "$1" -d "$2" --dart-define=SERVER_IP=$SERVER_IP \
    > >(verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter" >&2)

  FLUTTER_EXIT_CODE=$?
  if [ $FLUTTER_EXIT_CODE -ne 0 ]; then
    error_echo "${RED}Flutter tests failed.${NC}" "NO" $FLUTTER_EXIT_CODE
  fi
}

get_simulator_udids() {
  while IFS= read -r line; do
    name=$(echo "$line" | awk -F "(" '{print $1}' | xargs)
    udid=$(echo "$line" | grep -oE "[0-9A-Fa-f\-]{36}")
    [[ -n "$name" && -n "$udid" ]] && simulator_udids["$name"]="$udid"
  done < <(xcrun simctl list devices available)
}

start_simulator() {
  sim_udid=${simulator_udids["$1"]}
  verbose_echo "${BLUE}Booting simulator $1 ($sim_udid)...${NC}"
  xcrun simctl boot "$sim_udid"

  bootstatus=""
  while [[ "$bootstatus" != *"Booted"* ]]; do
    sleep 5
    bootstatus=$(xcrun simctl list devices | grep "$sim_udid")
    verbose_echo "${YELLOW}Waiting for $1 to boot...${NC}"
  done
  verbose_echo "${GREEN}$1 is ready.${NC}"
}

stop_simulators() {
  normal_echo "${YELLOW}Shutting down all simulators...${NC}"
  xcrun simctl shutdown all
  sleep 5
}

# Enforce scripts to fail on any error, unless explicitly allowed
set -eo pipefail

RESOLVED_REPO_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
OLDPWD=$(pwd)
cd "$RESOLVED_REPO_DIR"

exitfn() {
  # Move back to the original directory when the script exits, regardless of success or failure.
  cd "$OLDPWD"

  # Run script-specific cleanup functions if they exist
  if declare -f script_exitfn > /dev/null; then
    script_exitfn
  fi

  trap - EXIT
  trap - INT

  exit
}

intfn() {
  error_echo "${RED}Caught SIGINT. Cleaning up...${NC}" "YES"

  if declare -f script_intfn > /dev/null; then
    script_intfn
  fi

  exitfn
}

trap "exitfn" EXIT
trap "intfn" INT

