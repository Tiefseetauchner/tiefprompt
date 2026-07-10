# ANSI color codes
RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'
YELLOW=$'\033[0;33m'
BLUE=$'\033[0;34m'
NC=$'\033[0m' # No Color

unset -v QUIET
unset -v VERBOSE
unset -v MORE_VERBOSE

COMMON_PARAMS="qvVh"

parse_common_params() {
  case $1 in
    q)
      QUIET=YES
      ;;
    v)
      VERBOSE=YES
      ;;
    V)
      MORE_VERBOSE=YES
      ;;
    h)
      info
      exit 0
      ;;
  esac
}

help_common_params() {
  cat <<EOF
${GREEN}-q (*c)     ${NC}Make script quiet.
${GREEN}-v (*c)     ${NC}Make script verbose.
${GREEN}-V (*c)     ${NC}Make script extremely verbose (careful here!).
${GREEN}-h (*c)     ${NC}Show this help.
${BLUE}   (*c)     = common parameter, can be used in any script.
              may not take effect in all scripts, but will not cause an error.${NC}
EOF
}

normal_echo() {
  if [ -z "$QUIET" ]; then
    echo -e "$1"
  fi
}

error_echo() {
  SHOULD_CONTINUE=${2:-$CONTINUE_ON_FAIL}
  echo -e "${RED}ERROR: $1$NC" >&2
  if [ ! "$SHOULD_CONTINUE" = "YES" ]; then
    exit "${3:-1}"
  fi
}

normal_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    normal_echo "$GREEN$program_name:$NC $line"
  done
}

error_echo_stderr() {
  program_name="$1"
  while IFS= read -r line; do
    error_echo "$program_name: $NC $line" "YES"
  done
}

verbose_echo() {
  if [ "$VERBOSE" ] || [ "$MORE_VERBOSE" ]; then
    echo -e "$1"
  fi
}

verbose_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    verbose_echo "$GREEN$program_name:$NC $line"
  done
}

more_verbose_echo() {
  if [ "$MORE_VERBOSE" ]; then
    echo -e "$1"
  fi
}

more_verbose_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    more_verbose_echo "$GREEN$program_name:$NC $line"
  done
}

enable_iap() {
  if [ -f pubspec.yaml.iap_disabled ]; then
    normal_echo "pubspec.yaml.iap_disabled backup already exists. Cannot enable in-app purchase."
    normal_echo "To disable in-app purchase, run tools/disable_iap.sh first."
    error_echo "Aborting enable_iap." "NO" 1
  fi

  more_verbose_echo "${CYAN}Enabling in-app purchase in pubspec.yaml...${NC}"
  sed -i.iap_disabled 's/  # in_app_purchase/  in_app_purchase/g' pubspec.yaml
  more_verbose_echo "${CYAN}Getting dependencies after enabling in-app purchase...${NC}"
  .flutter/bin/flutter pub get > >(more_verbose_echo_stdin "flutter") 2> >(error_echo_stderr "flutter" >&2)
}

disable_iap() {
  if [ ! -f pubspec.yaml.iap_disabled ]; then
    normal_echo "pubspec.yaml.iap_disabled backup not found. Cannot disable in-app purchase."
    normal_echo "If this is unintentional, you can enable in-app purchases using tools/enable_iap.sh."
    error_echo "Aborting disable_iap." "NO" 1
  fi

  more_verbose_echo "${CYAN}Disabling in-app purchase in pubspec.yaml...${NC}"
  mv pubspec.yaml.iap_disabled pubspec.yaml
  more_verbose_echo "${CYAN}Getting dependencies after disabling in-app purchase...${NC}"
  .flutter/bin/flutter pub get > >(more_verbose_echo_stdin "flutter") 2> >(error_echo_stderr "flutter" >&2)
}


RESOLVED_REPO_DIR=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")/..")
OLDPWD=$(pwd)
cd "$RESOLVED_REPO_DIR"

# Move back to the original directory when the script exits, regardless of success or failure.
trap 'cd "$OLDPWD"' EXIT
