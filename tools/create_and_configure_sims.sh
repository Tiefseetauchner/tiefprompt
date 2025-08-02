#!/bin/zsh

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Checking for required tools...${NC}"

REQUIRED_TOOLS=("xcrun" "plutil")
for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo -e "${RED}Error: $tool is not installed or not in PATH.${NC}"
    exit 1
  fi
  echo -e "${GREEN}$tool is available.${NC}"
done

# Desired devices
DEVICES=(
  "iPhone 15 Pro Max=iPhone-6-9"
  "iPhone 14 Pro Max=iPhone-6-5"
  "iPad Pro (12.9-inch) (6th generation)=iPad-13"
)

# iOS runtime (adjust as needed)
RUNTIME=$(xcrun simctl list runtimes | grep -E 'iOS.*com.apple.CoreSimulator.SimRuntime.iOS' | grep -v unavailable | tail -1 | sed -E 's/.*(com\.apple\.CoreSimulator\.SimRuntime\.iOS[^[:space:]]*).*/\1/')

if [[ -z "$RUNTIME" ]]; then
  echo -e "${RED}No available iOS runtime found.${NC}"
  exit 1
fi

# Create simulators
for entry in "${DEVICES[@]}"; do
  DEVICE_NAME="${entry%=*}"
  CUSTOM_NAME="${entry#*=}"

  echo -e "${BLUE}Checking for existing simulator: $CUSTOM_NAME ($DEVICE_NAME)...${NC}"

  EXISTING=$(xcrun simctl list devices | grep "$CUSTOM_NAME")

  if [[ -n "$EXISTING" ]]; then
    echo -e "${YELLOW}Simulator $CUSTOM_NAME already exists. Skipping.${NC}"
    continue
  fi

  echo -e "${BLUE}Creating simulator $CUSTOM_NAME using $DEVICE_NAME...${NC}"

  xcrun simctl create "$CUSTOM_NAME" "$DEVICE_NAME" "$RUNTIME"

  if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}Simulator $CUSTOM_NAME created successfully.${NC}"
  else
    echo -e "${RED}Failed to create simulator $CUSTOM_NAME.${NC}"
  fi

done

echo -e "${GREEN}All specified simulators have been processed.${NC}"
