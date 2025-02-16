#!/bin/bash

declare -a emulators=("7intabled" "10intabled" "16by9phone")

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

start_http_server() {
  echo -e "${BLUE}Starting screenshot HTTP server for emulator: $CURRENT_EMULATOR${NC}"
  EMULATOR_NAME="$CURRENT_EMULATOR" dart integration_test/screenshot_server.dart &
  SERVER_PID=$!
  
  server_started=false
  while [[ "$server_started" != "true" ]]; do
    sleep 1
    server_started=$(curl -s http://localhost:7384/health)
    echo -e "${YELLOW}Waiting for start...${NC}"
  done

  echo -e "${GREEN}HTTP server started with PID: $SERVER_PID${NC}"
}

stop_http_server() {
  echo -e "${RED}Stopping screenshot HTTP server...${NC}"
  kill $SERVER_PID
}

start_emulator() {
  emulator_name=$1
  echo -e "${BLUE}Starting emulator: $emulator_name${NC}"
  nohup emulator -avd "$emulator_name" -no-audio -no-window &

  boot_completed=""
  while [[ "$boot_completed" != "1" ]]; do
    boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null)
    echo -e "${YELLOW}Waiting for $emulator_name to boot...${NC}"
    sleep 5
  done
  echo -e "${GREEN}$emulator_name is ready.${NC}"
}

run_tests() {
  echo -e "${BLUE}Starting Flutter testing...${NC}"
  flutter test integration_test/screenshot_automation_test.dart -d "emulator"
}

stop_emulator() {
  echo -e "${RED}Stopping emulator${NC}"
  adb emu kill
  sleep 5
}

# Run tests on all emulators
for emulator in "${emulators[@]}"; do
  CURRENT_EMULATOR="$emulator"
  start_http_server
  start_emulator "$CURRENT_EMULATOR"
  run_tests "$CURRENT_EMULATOR"
  stop_emulator
  stop_http_server
  echo -e "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"
done

echo -e "${GREEN}All tests completed on all emulators.${NC}"
