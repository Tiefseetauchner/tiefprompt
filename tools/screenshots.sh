#!/bin/bash

exitfn () {
  trap SIGINT
  stop_emulator
  echo -e "${RED}Killing screenshot HTTP server with PID: $SERVER_PID${NC}"
  kill $SERVER_PID
  exit
}

trap "exitfn" INT

declare -a emulators=("7intablet" "10intablet" "16by9phone")

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

start_http_server() {
  if [[ $(curl -s http://localhost:3824/health) != "true" ]]; then
    echo -e "${BLUE}Starting screenshot HTTP server for emulator: $CURRENT_EMULATOR${NC}"
    EMULATOR_NAME="$CURRENT_EMULATOR" .flutter/bin/dart integration_test/screenshot_server.dart &
    SERVER_PID=$!
  
    server_started=false
    while [[ "$server_started" != "true" ]]; do
      sleep 1
      server_started=$(curl -s http://localhost:3824/health)
      echo -e "${YELLOW}Waiting for start...${NC}"
    done
  fi

  if [[ $SERVER_PID == '' ]]; then
    echo -e "${YELLOW}Server seems to be running from previous run. This could be intended. If not, kill it manually.${NC}"
    return
  fi

  echo -e "${GREEN}HTTP server started with PID: $SERVER_PID${NC}"
}

stop_http_server() {
  echo -e "${RED}Stopping screenshot HTTP server...${NC}"
  if [[ $SERVER_PID == '' ]]; then
    echo -e "${YELLOW}Server seems to be running from previous run. This could be intended. If not, kill it manually.${NC}"
    return
  fi
  kill $SERVER_PID
}

start_emulator() {
  emulator_name=$1
  echo -e "${BLUE}Starting emulator: $emulator_name${NC}"
  nohup emulator -avd "$emulator_name" -no-audio -no-window &

  boot_completed=""
  while [[ $boot_completed != "1" ]]; do
    boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null)
    echo -e "${YELLOW}Waiting for $emulator_name to boot...${NC}"
    sleep 5
  done
  echo -e "${GREEN}$emulator_name is ready.${NC}"
}

enable_iap() {
  sed -i.iap_disabled 's/#  in_app_purchase/  in_app_purchase/g' pubspec.yaml
}

disable_iap() {
  mv pubspec.yaml.iap_disabled pubspec.yaml
}

run_tests() {
  enable_iap
  
  #SERVER_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | tail -n 1)
  SERVER_IP=10.0.2.2

  echo -e "${BLUE}SERVER_IP: $SERVER_IP${NC}"

  echo -e "${BLUE}Starting Flutter testing...${NC}"
  .flutter/bin/flutter test integration_test/screenshot_automation_test.dart -d "emulator" --dart-define=SERVER_IP=$SERVER_IP

  if [ $? -ne 0 ]; then
    echo -e "${RED}Flutter tests failed.${NC}"
    kill $SERVER_PID
    stop_emulator
    trap SIGINT
    exit 1
  fi

  disable_iap
}

stop_emulator() {
  echo -e "${RED}Stopping all emulators${NC}"
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
  echo -e "${GREEN}Finished tests on $CURRENT_EMULATOR${NC}"
done

echo -e "${GREEN}All tests completed on all emulators.${NC}"

trap SIGINT