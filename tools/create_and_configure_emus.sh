#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

info() {
  echo -e "${GREEN}Create and Configure Emulators for Android${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: create_and_configure_emus.sh [options]${NC}

${GREEN}-f          ${NC}Force recreate existing emulators if they already exist.
EOF

  help_common_params
}

unset -v FORCE_RECREATE

while getopts "f${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

  case "$opt" in
    f)
      FORCE_RECREATE="YES"
      ;;
    *)
      error_echo "Unknown option: -$opt" "NO" 1
      usage
      exit 1
      ;;
  esac
done

# Ensure required tools are installed
verbose_echo "${BLUE}Checking for required tools...${NC}"

# Ensure ANDROID_HOME is set
if [ -z "$ANDROID_HOME" ]; then
  error_echo "ANDROID_HOME is not set. Please set ANDROID_HOME to your Android SDK path." "NO" 1
fi

# Ensure necessary tools exist
REQUIRED_TOOLS=("sdkmanager" "avdmanager" "awk" "sed")

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    error_echo "$tool is not installed or not in PATH." "NO" 1
  fi
done

normal_echo "${GREEN}All required tools are installed.${NC}"

# Ensure required system image is installed
SYSTEM_IMAGE="system-images;android-36;default;x86_64"

verbose_echo "${BLUE}Checking if required system image is installed...${NC}"
if ! sdkmanager --list | grep -q "$SYSTEM_IMAGE"; then
  normal_echo "${YELLOW}System image not found. Installing now...${NC}"
  sdkmanager --install "$SYSTEM_IMAGE"
fi

normal_echo "${GREEN}System image is ready.${NC}"

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
  "MarketingTablet 1080 1150 7"
  "MarketingWideTablet 1920 1080 7"
)

if [ "$FORCE_RECREATE" == "YES" ]; then
  normal_echo "${YELLOW}Force recreate is enabled. Existing AVDs will be deleted.${NC}"
  for device in "${DEVICES[@]}"; do
    read -r name width height diagonal <<< "$device"
    if avdmanager list avd | grep -q "$name"; then
      normal_echo "${YELLOW}Deleting existing AVD: $name${NC}"
      avdmanager delete avd -n "$name"
    fi
  done
fi

# Create each AVD
for device in "${DEVICES[@]}"; do
  read -r name width height diagonal <<< "$device"
  density=$(calculate_density "$width" "$height" "$diagonal")

  verbose_echo "${BLUE}Creating AVD: $name${NC}"
  verbose_echo "  ${YELLOW}Resolution:${NC} ${width}x${height}"
  verbose_echo "  ${YELLOW}Density:${NC} ${density} dpi"

  # Check if AVD already exists
  if avdmanager list avd | grep -q "$name"; then
    normal_echo "${YELLOW}AVD $name already exists. Skipping creation.${NC}"
  else
    avdmanager create avd -n "$name" -k "$SYSTEM_IMAGE" --device "Nexus 5" --force \
      > >(normal_echo_stdin "avdmanager") \
      2> >(error_echo_stderr "avdmanager (error)")
    verbose_echo "${GREEN}AVD $name created.${NC}"
  fi

  # Modify config.ini with correct resolution and density
  CONFIG_FILE="$HOME/.android/avd/$name.avd/config.ini"

  if [ -f "$CONFIG_FILE" ]; then
    verbose_echo "${BLUE}Updating AVD configuration...${NC}"

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

  normal_echo "${GREEN}AVD $name configured successfully.${NC}"
done

normal_echo "${GREEN}All AVDs have been created and configured.${NC}"
