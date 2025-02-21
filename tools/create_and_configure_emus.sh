#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ensure required tools are installed
echo -e "${BLUE}Checking for required tools...${NC}"

# Ensure ANDROID_HOME is set
if [ -z "$ANDROID_HOME" ]; then
  echo -e "${RED}Error: ANDROID_HOME is not set. Please set ANDROID_HOME to your Android SDK path.${NC}"
  exit 1
fi

# Ensure necessary tools exist
REQUIRED_TOOLS=("sdkmanager" "avdmanager" "awk" "sed")

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo -e "${RED}Error: $tool is not installed or not in PATH.${NC}"
    exit 1
  fi
done

echo -e "${GREEN}All required tools are installed.${NC}"

# Ensure required system image is installed
SYSTEM_IMAGE="system-images;android-24;default;x86_64"

echo -e "${BLUE}Checking if required system image is installed...${NC}"
if ! sdkmanager --list | grep -q "$SYSTEM_IMAGE"; then
  echo -e "${YELLOW}System image not found. Installing now...${NC}"
  sdkmanager --install "$SYSTEM_IMAGE"
fi

echo -e "${GREEN}System image is ready.${NC}"

# Function to calculate density
calculate_density() {
  local width=$1
  local height=$2
  local diagonal=$3

  # Calculate density using the formula: dpi = sqrt(width^2 + height^2) / diagonal
  echo $(awk "BEGIN { printf \"%d\", sqrt($width^2 + $height^2) / $diagonal }")
}

# Define device parameters
DEVICES=(
  "7intablet 1024 600 7"
  "10intablet 2560 1600 10"
  "16by9phone 1080 1920 5.5"
)

# Create each AVD
for device in "${DEVICES[@]}"; do
  read -r name width height diagonal <<< "$device"
  density=$(calculate_density "$width" "$height" "$diagonal")

  echo -e "${BLUE}Creating AVD: $name${NC}"
  echo -e "  ${YELLOW}Resolution:${NC} ${width}x${height}"
  echo -e "  ${YELLOW}Density:${NC} ${density} dpi"

  # Check if AVD already exists
  if avdmanager list avd | grep -q "$name"; then
    echo -e "${YELLOW}AVD $name already exists. Skipping creation.${NC}"
  else
    avdmanager create avd -n "$name" -k "$SYSTEM_IMAGE" --device "Nexus 5" --force
    echo -e "${GREEN}AVD $name created.${NC}"
  fi

  # Modify config.ini with correct resolution and density
  CONFIG_FILE="$HOME/.android/avd/$name.avd/config.ini"

  if [ -f "$CONFIG_FILE" ]; then
    echo -e "${BLUE}Updating AVD configuration...${NC}"

    # Remove existing keys if they exist, handling whitespace variations
    sed -i '/^hw\.lcd\.height[[:space:]]*=/d' "$CONFIG_FILE"
    sed -i '/^hw\.lcd\.width[[:space:]]*=/d' "$CONFIG_FILE"
    sed -i '/^hw\.lcd\.density[[:space:]]*=/d' "$CONFIG_FILE"
  fi

  # Append new values
  {
    echo "hw.lcd.height=$height"
    echo "hw.lcd.width=$width"
    echo "hw.lcd.density=$density"
  } >> "$CONFIG_FILE"

  echo -e "${GREEN}AVD $name configured successfully.${NC}"
done

echo -e "${GREEN}All AVDs have been created and configured.${NC}"
