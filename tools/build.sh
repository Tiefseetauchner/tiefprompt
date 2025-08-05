#!/bin/bash
set -e

GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
CYAN=$'\033[0;36m'
RESET=$'\033[0;0m'

info() {
  echo -e "${GREEN}Build TiefPrompt packages.${RESET}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: build.sh [options]${RESET}

${GREEN}-t target   ${RESET}Comma seperated list of targets to build. Options:
            linux,windows,androidaab,androidapk,macos,macospkg,iosapp,iosipa
            (i) Can be set via environment variable 'TARGETS'
            ${RED}(!) Required${RESET}
${GREEN}-f freedom  ${RESET}Comma seperated list of freedoms. Options:
            freemium,foss
            (i) Can be set via environment variable 'FREEDOM'
            ${RED}(!) Required${RESET}
${GREEN}-b dir      ${RESET}Build directory to place packages in.
            Default: /package
            (i) Unix path interpreted from current directory.
            (i) Can be set via environment variable 'BUILD_DIR'
${GREEN}-s          ${RESET}Skip Flutter preperation.
${GREEN}-d          ${RESET}Run debug build.
${GREEN}-c          ${RESET}Continue on fail.
${GREEN}-q          ${RESET}Make script quiet.
${GREEN}-v          ${RESET}Make script verbose.
${GREEN}-V          ${RESET}Make script extremely verbose (careful here!).
${GREEN}-k key      ${RESET}Signing identity for macOS packaging.
${GREEN}-h          ${RESET}Show this help.
EOF
}

error_echo() {
  echo -e "${RED}ERROR: $1$RESET"
  if [ "$CONTINUE_ON_FAIL" ]; then
    echo "${RED}Continuing...$RESET"
  else
    exit $2
  fi
}

normal_echo() {
  if [ -z "$QUIET" ]; then
    echo -e "$1"
  fi
}

normal_echo_stdin() {
  program_name="$1"
  while IFS= read -r line; do
    normal_echo "$GREEN$program_name:$RESET $line"
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
    verbose_echo "$GREEN$program_name:$RESET $line"
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
    more_verbose_echo "$GREEN$program_name:$RESET $line"
  done
}

compress_directory() {
  output="$1"
  shift
  inputs=("$@")

  if command -v 7z &>/dev/null; then
    7z a "$output" "${inputs[@]}" \
      > >(more_verbose_echo_stdin "7z") \
      2> >(normal_echo_stdin "${RED}7z (error)${RESET}")
    return $?
  elif command -v zip &>/dev/null; then
    zip -r "$output" "${inputs[@]}" \
      > >(more_verbose_echo_stdin "zip") \
      2> >(normal_echo_stdin "${RED}zip (error)${RESET}")
    return $?
  else
    error_echo "No suitable compression tool (7z or zip) found."
    return 127
  fi
}

BUILD_DIR="/package"
unset -v QUIET
unset -v VERBOSE
unset -v MORE_VERBOSE
unset -v MACOS_SIGN_KEY
RESULT=0

while getopts "t:f:b:k:hvVcdsq" opt; do
  case $opt in
    t)
      TARGETS=$OPTARG
      ;;
    f)
      FREEDOM=$OPTARG
      ;;
    b)
      BUILD_DIR=$OPTARG
      ;;
    k)
      MACOS_SIGN_KEY=$OPTARG
      ;;
    q)
      QUIET=YES
      ;;
    v)
      VERBOSE=YES
      ;;
    V)
      MORE_VERBOSE=YES
      ;;
    c)
      CONTINUE_ON_FAIL=YES
      ;;
    d)
      RUN_DEBUG_BUILD=YES
      ;;
    s)
      SKIP_FLUTTER_SETUP=YES
      ;;
    h)
      info
      exit 0
      ;;
    \?)
      echo "Use -h for help"
      exit 1
      ;;
  esac
done

if [ -z "$TARGETS" ] || [ -z "$FREEDOM" ]; then
  error_echo "-t (targets) and -f (freedom) must be set to run this script." 1
  exit 1
fi

TARGETS_LIST=$(echo "$TARGETS" | tr ',' ' ')
FREEDOM_LIST=$(echo "$FREEDOM" | tr ',' ' ')

normal_echo "${CYAN}Building Flutter applications...${RESET}"

if [ -z "$SKIP_FLUTTER_SETUP" ]; then
  verbose_echo "${CYAN}Setting .flutter to be a safe git directory${RESET}"
  git config --global --add safe.directory "$(pwd)/.flutter" \
    > >(verbose_echo_stdin "git") \
    2> >(normal_echo_stdin "${RED}git (error)${RESET}")
  git_status=$?
  if [ ! $git_status -eq 0 ]; then
    error_echo "git config failed with status code ${git_status}." $git_status
    RESULT=$git_status
  fi
  verbose_echo "${CYAN}Disabling flutter analytics...${RESET}"
  .flutter/bin/flutter --disable-analytics \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stdin "${RED}flutter (error)${RESET}")
  verbose_echo "${CYAN}Disabling flutter cli animations...${RESET}"
  .flutter/bin/flutter config --no-cli-animations \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stdin "${RED}flutter (error)${RESET}")
  verbose_echo "${CYAN}Checking and preparing flutter...${RESET}"
  .flutter/bin/flutter doctor \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stdin "${RED}flutter (error)${RESET}")
  verbose_echo "${CYAN}Cleaning with flutter...${RESET}"
  .flutter/bin/flutter clean \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stdin "${RED}flutter (error)${RESET}")
  verbose_echo "${CYAN}Getting flutter packages...${RESET}"
  .flutter/bin/flutter pub get \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stdin "${RED}flutter (error)${RESET}")
fi
if [ "$CONTINUE_ON_FAIL" ]; then
  unset -e
fi

for freedom in $FREEDOM_LIST; do
  for target in $TARGETS_LIST; do
    verbose_echo "${YELLOW}Processing Target $target for freedom $freedom...${RESET}"

    if [ "$RUN_DEBUG_BUILD" ]; then
      configuration=debug
    else
      configuration=release
    fi

    msix_output=
    should_compress=
    compress_path=
    case $target in
      linux)
        target_options=linux
        target_results=build/linux/x64/$configuration/bundle
        should_compress=YES
        compress_path="linux.zip"
        ;;
      windows)
        target_options=windows
        target_results=build/windows/x64/runner/$configuration
        should_compress=YES
        compress_path="windows.zip"
        ;;
      windowsmsix)
        target_options=windows
        target_results=build/windows/x64/runner/$configuration/*.msix
        ;;
      androidaab)
        target_options=appbundle
        target_results=build/app/outputs/bundle/$configuration/*
        ;;
      androidapk)
        target_options='apk --split-per-abi'
        target_results="build/app/outputs/apk/$configuration/app*"
        ;;
      macos)
        target_options=macos
        target_results="build/macos/Build/Products/$configuration"
        should_compress=YES
        compress_path="macos.zip"
        ;;
      macospkg)
        target_options=macos
        target_results="build/macos/Build/Products/$configuration"
        ;;
      iosapp)
        target_options=ios
        target_results="build/ios/$configuration-iphoneos"
        should_compress=YES
        compress_path="iosapp.zip"
        ;;
      iosipa)
        target_options=ipa
        target_results="build/ios/ipa/*.ipa"
        ;;
      *)
        error_echo "Target $target could not be identified. See -h for valid targets." 1
        continue
        ;;
    esac

    if [ "$RUN_DEBUG_BUILD" ]; then
      target_options+=' --debug'
    else
      target_options+=' --release'
    fi

    case $freedom in
      freemium)
        target_options+=' -t lib/main_freemium.dart'
        ;;
      foss)
        target_options+=' -t lib/main_foss.dart'
        ;;
      *)
        error_echo "Freedom option $freedom could not be identified. See -h for valid freedom options." 1
        continue
        ;;
    esac

    more_verbose_echo "${CYAN}Building with target options: '$target_options'${RESET}"

    normal_echo "${GREEN}Building for target $target and freedom $freedom...${RESET}"
    .flutter/bin/flutter build $target_options \
      > >(verbose_echo_stdin "flutter") \
      2> >(normal_echo_stdin "${RED}flutter (error)${RESET}")
    flutter_status=$?
    if [ ! $flutter_status -eq 0 ]; then
      error_echo "Flutter exited with status code ${flutter_status}." $flutter_status
      RESULT=$flutter_status
    fi

    if [ "$target" = "windowsmsix" ]; then
      verbose_echo "${CYAN}Creating MSIX package...${RESET}"
      .flutter/bin/flutter pub run msix:create --install-certificate false  \
        > >(verbose_echo_stdin "msix") \
        2> >(normal_echo_stdin "${RED}msix (error)${RESET}")
      msix_status=$?
      if [ ! $msix_status -eq 0 ]; then
        error_echo "MSIX packaging failed with status code ${msix_status}." $msix_status
        RESULT=$msix_status
      fi
    fi

    if [ "$target" = "macospkg" ]; then
      pkg_name="macos.pkg"
      if [ "$MACOS_SIGN_KEY" ]; then
        verbose_echo "${CYAN}Signing macOS app...${RESET}"
        runner_app_path=$(find $target_results -type file -iname "*.app")
        codesign --force --deep -s "$MACOS_SIGN_KEY" "$runner_app_path" \
          > >(verbose_echo_stdin "codesign") \
          2> >(normal_echo_stdin "${RED}codesign (error)${RESET}")
        codesign_status=$?
        if [ ! $codesign_status -eq 0 ]; then
          error_echo "codesign failed with status code ${codesign_status}." $codesign_status
          RESULT=$codesign_status
        fi
      fi
      pkgbuild --install-location /Applications --component "$target_results/Runner.app" "$target_results/$pkg_name" \
        > >(verbose_echo_stdin "pkgbuild") \
        2> >(normal_echo_stdin "${RED}pkgbuild (error)${RESET}")
      pkg_status=$?
      if [ ! $pkg_status -eq 0 ]; then
        error_echo "macOS packaging failed with status code ${pkg_status}." $pkg_status
        RESULT=$pkg_status
      fi
      target_results="$target_results/$pkg_name"
    fi

    more_verbose_echo "${CYAN}Finished building for target $target${RESET}"
    verbose_echo "${CYAN}Packaging Build...${RESET}"

    if [ "$should_compress" ]; then
      # We need to change dir so the zip has the right structure
      pushd $target_results > /dev/null
      verbose_echo "${CYAN}Compressing build in $target_results to $compress_path${RESET}"
      compress_directory "$compress_path" *
      zip_status=$?
      # And back again
      popd > /dev/null
      if [ ! $zip_status -eq 0 ]; then
        error_echo "compression failed with exited with status code ${zip_status}." $zip_status
        RESULT=$zip_status
      fi

      target_results=$target_results/$compress_path
    fi

    verbose_echo "${CYAN}Copying $target_results to $BUILD_DIR${RESET}"
    mkdir -p "$BUILD_DIR/$freedom" \
      > >(verbose_echo_stdin "mkdir") \
      2> >(normal_echo_stdin "${RED}mkdir (error)${RESET}")
    cp $target_results "$BUILD_DIR/$freedom" \
      > >(verbose_echo_stdin "cp") \
      2> >(normal_echo_stdin "${RED}cp (error)${RESET}")
    cp_status=$?
    if [ ! $cp_status -eq 0 ]; then
      error_echo "cp exited with status code ${cp_status}." $cp_status
      RESULT=$cp_status
    fi
  done
done

normal_echo "${GREEN}All builds completed successfully. Packages are available in: $BUILD_DIR${RESET}"

exit $RESULT
