#!/bin/zsh

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Declare arrays
simulators=("iPhone-6-9" "iPhone-6-5" "iPad-13")
typeset -A simulator_udids

# Graceful shutdown
exitfn() {
  trap - SIGINT
  stop_simulators
  echo -e "${RED}Killing screenshot HTTP server with PID: $SERVER_PID${NC}"
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
    echo -e "${BLUE}Starting screenshot HTTP server for simulator: $CURRENT_SIMULATOR${NC}"
    DEVICE_NAME="$CURRENT_SIMULATOR" .flutter/bin/dart integration_test/screenshot_server.dart &
    SERVER_PID=$!

    server_started=false
    while [[ "$server_started" != "true" ]]; do
      sleep 1
      server_started=$(curl -s http://localhost:3824/health)
      echo -e "${YELLOW}Waiting for server to start...${NC}"
    done
  fi
  echo -e "${GREEN}HTTP server started with PID: $SERVER_PID${NC}"
}

stop_http_server() {
  echo -e "${RED}Stopping screenshot HTTP server...${NC}"
  if [[ -z "$SERVER_PID" ]]; then
    echo -e "${YELLOW}Server seems to be running from previous run. Kill it manually if needed.${NC}"
    return
  fi
  kill $SERVER_PID 2>/dev/null
  unset SERVER_PID
}

start_simulator() {
  sim_udid=${simulator_udids["$1"]}
  echo -e "${BLUE}Booting simulator $1 ($sim_udid)...${NC}"
  xcrun simctl boot "$sim_udid"

  bootstatus=""
  while [[ "$bootstatus" != *"Booted"* ]]; do
    sleep 5
    bootstatus=$(xcrun simctl list devices | grep "$sim_udid")
    echo -e "${YELLOW}Waiting for $1 to boot...${NC}"
  done
  echo -e "${GREEN}$1 is ready.${NC}"
}

stop_simulators() {
  echo -e "${RED}Shutting down all simulators...${NC}"
  xcrun simctl shutdown all
  sleep 5
}

run_tests() {
  SERVER_IP=127.0.0.1
  echo -e "${BLUE}SERVER_IP: $SERVER_IP${NC}"
  echo -e "${BLUE}Starting Flutter testing...${NC}"
  .flutter/bin/flutter test integration_test/screenshot_automation_test.dart --dart-define=SERVER_IP=$SERVER_IP

  if [[ $? -ne 0 ]]; then
    echo -e "${RED}Flutter tests failed.${NC}"
    stop_simulators
    kill $SERVER_PID 2>/dev/null
    trap - SIGINT
    exit 1
  fi
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
  echo -e "${GREEN}Finished tests on $CURRENT_SIMULATOR${NC}"
  echo
done

echo -e "${GREEN}All tests completed on all simulators.${NC}"
trap - SIGINT
