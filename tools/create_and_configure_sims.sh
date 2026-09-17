#!/bin/zsh

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

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

  case "$opt" in
    *)
      error_echo "Unknown option: -$opt" "NO" 1
      usage
      exit 1
      ;;
  esac
done

verbose_echo "${BLUE}Checking for required tools...${NC}"

REQUIRED_TOOLS=("xcrun" "plutil")
for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    error_echo "${RED}$tool is not installed or not in PATH.${NC}" "NO" 1
  fi
  verbose_echo "${GREEN}$tool is available.${NC}"
done

# Desired devices
DEVICES=(
  "iPhone 16 Pro Max=iPhone-6-9"
  "iPhone 16 Pro=iPhone-6-5"
  "iPad Pro 13-inch (M4)=iPad-13"
)

# iOS runtime (adjust as needed)
RUNTIME=$(xcrun simctl list runtimes | grep -E 'iOS.*com.apple.CoreSimulator.SimRuntime.iOS' | grep -v unavailable | tail -1 | sed -E 's/.*(com\.apple\.CoreSimulator\.SimRuntime\.iOS[^[:space:]]*).*/\1/')

if [[ -z "$RUNTIME" ]]; then
  error_echo "${RED}No available iOS runtime found.${NC}" "NO" 1
fi

# Create simulators
for entry in "${DEVICES[@]}"; do
  DEVICE_NAME="${entry%=*}"
  CUSTOM_NAME="${entry#*=}"

  verbose_echo "${BLUE}Checking for existing simulator: $CUSTOM_NAME ($DEVICE_NAME)...${NC}"

  EXISTING=$(xcrun simctl list devices | grep "$CUSTOM_NAME")

  if [[ -n "$EXISTING" ]]; then
    normal_echo "${YELLOW}Simulator $CUSTOM_NAME already exists. Skipping.${NC}"
    continue
  fi

  verbose_echo "${BLUE}Creating simulator $CUSTOM_NAME using $DEVICE_NAME...${NC}"

  xcrun simctl create "$CUSTOM_NAME" "$DEVICE_NAME" "$RUNTIME" \
    > >(verbose_echo_stdin "simctl") \
    2> >(error_echo_stderr "simctl (error)")

  if [[ $? -eq 0 ]]; then
    normal_echo "${GREEN}Simulator $CUSTOM_NAME created successfully.${NC}"
  else
    error_echo "${RED}Failed to create simulator $CUSTOM_NAME.${NC}" "NO" 1
  fi

done

normal_echo "${GREEN}All specified simulators have been processed.${NC}"
