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
done

exitfn () {
  error_echo "${RED}Caught SIGINT. Shutting down emulators and stopping server...${NC}" "YES"
  trap - SIGINT
  stop_emulator
  stop_http_server
  disable_iap
  exit
}

trap "exitfn" INT

declare -a emulators=("7intablet" "10intablet" "16by9phone")

start_http_server() {
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

stop_http_server() {
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
  nohup emulator -avd "$emulator_name" -no-audio -no-window &

  boot_completed=""
  while [[ $boot_completed != "1" ]]; do
    boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null)
    verbose_echo "${YELLOW}Waiting for $emulator_name to boot...${NC}"
    sleep 5
  done
  verbose_echo "${GREEN}$emulator_name is ready.${NC}"
}

run_tests() {
  enable_iap

  .flutter/bin/flutter pub get
  
  #SERVER_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | tail -n 1)
  SERVER_IP=10.0.2.2

  verbose_echo "${BLUE}SERVER_IP: $SERVER_IP${NC}"

  verbose_echo "${BLUE}Starting Flutter testing...${NC}"
  .flutter/bin/flutter test integration_test/screenshot_automation_test.dart -d "emulator" --dart-define=SERVER_IP=$SERVER_IP

  if [ $? -ne 0 ]; then
    error_echo "${RED}Flutter tests failed.${NC}" "YES"
    stop_http_server
    stop_emulator
    trap - SIGINT
    exit 1
  fi

  disable_iap
}

stop_emulator() {
  verbose_echo "${YELLOW}Stopping all emulators...${NC}"
  adb emu kill -as
  sleep 5
}

# Run tests on all emulators
for emulator in "${emulators[@]}"; do
  CURRENT_EMULATOR="$emulator"
  start_http_server
  start_emulator "$CURRENT_EMULATOR"
  run_tests "$CURRENT_EMULATOR"
  stop_emulator
  sleep 5
  stop_http_server
  normal_echo "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"
done

normal_echo "${GREEN}All tests completed on all emulators.${NC}"

trap - SIGINT