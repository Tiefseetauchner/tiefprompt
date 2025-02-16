#!/bin/bash

declare -a emulators=("7intabled" "10intabled" "16by9phone")

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

  echo -e "${YELLOW}Reinstalling app...${NC}"
  flutter install
}

run_tests() {
  echo -e "${BLUE}Starting the app before tests...${NC}"
  flutter run -d "$1" 
  sleep 5

  echo -e "${BLUE}Starting Flutter app for testing...${NC}"
  flutter test test/screenshot_automation/screenshot_automation_test.dart
}

stop_emulator() {
  echo -e "${RED}Stopping emulator${NC}"
  adb emu kill
  sleep 5
}

for emulator in "${emulators[@]}"; do
  start_emulator "$emulator"
  run_tests "$emulator"
  stop_emulator
  echo -e "${GREEN}Finished tests on $emulator${NC}"
done

echo -e "${GREEN}All tests completed on all emulators.${NC}"
