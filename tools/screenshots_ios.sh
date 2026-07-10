#!/bin/zsh

source tools/common.sh

info() {
  echo -e "${GREEN}Create and Configure Simulators for iOS${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: create_and_configure_sims.sh [options]${NC}

EOF

  help_common_params
}

while getopts "${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi
done

# Declare arrays
simulators=("iPhone-6-9" "iPhone-6-5" "iPad-13")
typeset -A simulator_udids

# Graceful shutdown
exitfn() {
  error_echo "${RED}Caught SIGINT. Shutting down simulators and stopping server...${NC}"
  trap - SIGINT
  stop_simulators
  verbose_echo "${YELLOW}Killing screenshot HTTP server with PID: $SERVER_PID${NC}"
  kill $SERVER_PID 2>/dev/null
  exit
}

trap "exitfn" INT

get_simulator_udids() {
  while IFS= read -r line; do
    name=$(echo "$line" | awk -F "(" '{print $1}' | xargs)
    udid=$(echo "$line" | grep -oE "[0-9A-Fa-f\-]{36}")
    [[ -n "$name" && -n "$udid" ]] && simulator_udids["$name"]="$udid"
  done < <(xcrun simctl list devices available)
}

start_http_server() {
  if [[ $(curl -s http://localhost:3824/health) != "true" ]]; then
    verbose_echo "${BLUE}Starting screenshot HTTP server for simulator: $CURRENT_SIMULATOR${NC}"
    DEVICE_NAME="$CURRENT_SIMULATOR" .flutter/bin/dart integration_test/screenshot_server.dart \
      > >(verbose_echo_stdin "screenshot_server") \
      2> >(error_echo_stderr "screenshot_server (error)") &
    SERVER_PID=$!

    server_started=false
    while [[ "$server_started" != "true" ]]; do
      sleep 1
      server_started=$(curl -s http://localhost:3824/health)
      verbose_echo "${YELLOW}Waiting for server to start...${NC}"
    done
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

run_tests() {
  enable_iap

  SERVER_IP=127.0.0.1
  verbose_echo "${BLUE}SERVER_IP: $SERVER_IP${NC}"
  verbose_echo "${BLUE}Starting Flutter testing...${NC}"
  .flutter/bin/flutter test integration_test/screenshot_automation_test.dart --dart-define=SERVER_IP=$SERVER_IP \
    > >(verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter (error)")

  if [[ $? -ne 0 ]]; then
    error_echo "${RED}Flutter tests failed.${NC}"
    stop_simulators
    stop_http_server
    trap - SIGINT
    exit 1
  fi

  disable_iap
}

get_simulator_udids

for simulator in "${simulators[@]}"; do
  CURRENT_SIMULATOR="$simulator"
  start_http_server
  start_simulator "$CURRENT_SIMULATOR"
  run_tests "$CURRENT_SIMULATOR"
  stop_simulators
  sleep 5
  stop_http_server
  normal_echo "${GREEN}Finished tests on $CURRENT_SIMULATOR${NC}"
  echo
done

normal_echo "${GREEN}All tests completed on all simulators.${NC}"
trap - SIGINT
