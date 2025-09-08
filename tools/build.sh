#!/bin/bash
set -e

GREEN=$'\033[0;32m'
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
CYAN=$'\033[0;36m'
RESET=$'\033[0;0m'

error_echo() {
  echo -e "${RED}ERROR: $1$RESET"
  if [ "$CONTINUE_ON_FAIL" ]; then
    echo "${RED}Continuing...$RESET"
  else
    exit "$2"
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

# This has to be separated and piped to stderr.
# > >(...) captures the stdout of 2> >(...) as well,
# so the error log would get swallowed by the normal logging.
normal_echo_stderr() {
  normal_echo_stdin "$@" >&2
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

prepare_flutter() {
  verbose_echo "${CYAN}Setting .flutter to be a safe git directory${RESET}"
  git config --global --add safe.directory "$(pwd)/.flutter" \
    > >(verbose_echo_stdin "git") \
    2> >(normal_echo_stderr "${RED}git (error)")
  verbose_echo "${CYAN}Disabling flutter analytics...${RESET}"
  .flutter/bin/flutter --disable-analytics \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stderr "${RED}flutter (error)")
  verbose_echo "${CYAN}Disabling flutter cli animations...${RESET}"
  .flutter/bin/flutter config --no-cli-animations \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stderr "${RED}flutter (error)")
  verbose_echo "${CYAN}Checking and preparing flutter...${RESET}"
  .flutter/bin/flutter doctor \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stderr "${RED}flutter (error)")
  verbose_echo "${CYAN}Cleaning with flutter...${RESET}"
  .flutter/bin/flutter clean \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stderr "${RED}flutter (error)")
  verbose_echo "${CYAN}Getting flutter packages...${RESET}"
  .flutter/bin/flutter pub get \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(normal_echo_stderr "${RED}flutter (error)")
}

build_flutter() {
  normal_echo "${GREEN}Building for target $1 and freedom $2...${RESET}"
  shift 2
  flutter_args=("$@")
  .flutter/bin/flutter build "${flutter_args[@]}" \
    > >(verbose_echo_stdin "flutter") \
    2> >(normal_echo_stderr "${RED}flutter (error)")
  return $?
}

build_msix() {
  verbose_echo "${CYAN}Creating MSIX package...${RESET}"
  .flutter/bin/flutter pub run msix:create --install-certificate false  \
    > >(verbose_echo_stdin "msix") \
    2> >(normal_echo_stderr "${RED}msix (error)")
  msix_status=$?
  if [ ! $msix_status -eq 0 ]; then
    error_echo "MSIX packaging failed with status code ${msix_status}." $msix_status
  fi
}

get_first_app() {
  find "$1" -type d -iname "*.app" | head -n 1
}

sign_macos() {
  if [ -z "$MACOS_CODE_SIGN_KEY" ]; then
    error_echo "-k must be set if building macOS to sign the binaries." 127
    return 127
  fi

  app_name=$(get_first_app "$1")
  
  xattr -rc "$app_name"

  verbose_echo "${CYAN}Cleaning up embedded frameworks...${RESET}"
  find "$app_name/Contents/Frameworks" -type d -name "*.framework" | while read -r framework; do
    for file in "$framework"/*; do
      fname=$(basename "$file")
      if [[ "$fname" != "Versions" && "$fname" != *.framework ]]; then
        verbose_echo "Removing unexpected file from $framework: $fname"
        rm -rf "$file"
      fi
    done
  done

  verbose_echo "${CYAN}Signing macOS app and nested binaries...${RESET}"

  while IFS= read -r bin; do
    verbose_echo "${CYAN}Signing nested binary: $bin${RESET}"
    codesign --force --verify --verbose --timestamp \
      --sign "$MACOS_CODE_SIGN_KEY" "$bin" \
      > >(verbose_echo_stdin "codesign (nested)") \
      2> >(normal_echo_stderr "${RED}codesign (nested error)")
  done < <(find "$app_name/Contents/Frameworks" -type f \( -name "*.dylib" -o -name "*.so" -o -perm -111 \))


  main_exec="$app_name/Contents/MacOS/$(basename "$app_name" .app)"
  if [ -f "$main_exec" ]; then
    verbose_echo "${CYAN}Signing main executable: $main_exec with entitlements${RESET}"
    codesign --force --verify --verbose --timestamp \
      --entitlements macos/Runner/Release.entitlements \
      --sign "$MACOS_CODE_SIGN_KEY" "$main_exec" \
      > >(verbose_echo_stdin "codesign (main exec)") \
      2> >(normal_echo_stderr "${RED}codesign (main exec error)")
  else
    error_echo "Main executable not found at $main_exec" 1
  fi

  codesign --force --verify --verbose --timestamp \
    --sign "$MACOS_CODE_SIGN_KEY" "$app_name" \
    > >(verbose_echo_stdin "codesign (main app)") \
    2> >(normal_echo_stderr "${RED}codesign (main app error)")
  codesign_status=$?
  if [ ! $codesign_status -eq 0 ]; then
    error_echo "codesign failed with status code ${codesign_status}." $codesign_status
  fi
}

package_macos() {
  app_name=$(get_first_app "$1")
  package_name="${app_name%.app}.pkg"

  if [ -z "$MACOS_PACKAGE_SIGN_KEY" ]; then
    error_echo "-K must be set if building macOS packages to sign the pkg." 127
    return 127
  fi

  if [ -z "$MACOS_PROVISIONING_PROFILE" ]; then
    error_echo "-p must be set if building macOS packages to provide the provisioning profile." 127
    return 127
  fi

  more_verbose_echo "${CYAN}Copying Provisioning Profile${RESET}"
  cp "$MACOS_PROVISIONING_PROFILE" "$app_name/Contents/embedded.provisionprofile" \
    > >(verbose_echo_stdin "cp provisionprofile") \
    2> >(normal_echo_stderr "${RED}cp provisionprofile (error)")

  more_verbose_echo "${CYAN}Running product build with sign key $MACOS_PACKAGE_SIGN_KEY, component $app_name and package $package_name.${RESET}"
  productbuild --sign "$MACOS_PACKAGE_SIGN_KEY" --component "$app_name" "/Applications" "$package_name" \
    > >(verbose_echo_stdin "productbuild") \
    2> >(normal_echo_stderr "${RED}productbuild (error)")
  pkg_status=$?
  if [ ! $pkg_status -eq 0 ]; then
    error_echo "macOS packaging failed with status code ${pkg_status}." $pkg_status
    return 127
  fi

  PACKAGE_MACOS_RESULT=$package_name

  return 0
}

sign_ios() {
  if [ -z "$IOS_CODE_SIGN_KEY" ]; then
    error_echo "-i must be set to sign the .app." 127
    return 127
  fi

  if [ -z "$IOS_PROVISIONING_PROFILE" ]; then
    error_echo "-P must be set to embed the profile." 127
    return 127
  fi

  app_path=$(find "$1" -name "*.app" -maxdepth 1)

  cp "$IOS_PROVISIONING_PROFILE" "$app_path/embedded.mobileprovision" \
    > >(verbose_echo_stdin "cp mobileprovision") \
    2> >(normal_echo_stderr "${RED}cp mobileprovision (error)")

  entitlements_plist=$1/entitlements.plist
  security cms -D -i "$IOS_PROVISIONING_PROFILE" 2>/dev/null |
    plutil -extract Entitlements xml1 -o - - >"$entitlements_plist"

  xattr -rc "$app_path"

  if [ -d "$app_path/Frameworks" ]; then
    find "$app_path/Frameworks" -type d -name "*.framework" | while read -r framework; do
      codesign --force --timestamp --sign "$IOS_CODE_SIGN_KEY" --preserve-metadata=identifier,entitlements "$framework" \
        > >(verbose_echo_stdin "codesign") \
        2> >(normal_echo_stderr "${RED}codesign (error)")
    done
  fi

  codesign --force --timestamp --sign "$IOS_CODE_SIGN_KEY" --entitlements "$entitlements_plist" "$app_path" \
    > >(verbose_echo_stdin "codesign") \
    2> >(normal_echo_stderr "${RED}codesign (error)")
}

package_ios_ipa() {
  build_dir="$1"
  app_path=$(find "$build_dir" -maxdepth 1 -name "*.app" -type d)

  ipa_name="$(basename "${app_path%.app}.ipa")"
  tmpdir=$build_dir/ipa_temp
  more_verbose_echo "${CYAN}Creating temp dir $tmpdir/Payload${RESET}"
  mkdir -p "$tmpdir" \
    > >(more_verbose_echo_stdin "mkdir") \
    2> >(normal_echo_stderr "${RED}mkdir (error)")
  mkdir -p "$tmpdir/Payload" \
    > >(more_verbose_echo_stdin "mkdir") \
    2> >(normal_echo_stderr "${RED}mkdir (error)")
  more_verbose_echo "${CYAN}Copying $app_path to $tmpdir/Payload${RESET}"
  cp -R "$app_path" "$tmpdir/Payload/" \
    > >(more_verbose_echo_stdin "cp") \
    2> >(normal_echo_stderr "${RED}cp (error)")
  more_verbose_echo "${CYAN}Zipping $tmpdir/Payload to $ipa_name${RESET}"
  (cd "$tmpdir" && \
    zip -r "$ipa_name" Payload \
      > >(more_verbose_echo_stdin "zip") \
      2> >(normal_echo_stderr "${RED}zip (error)"))
  mv "$tmpdir/$ipa_name" "$build_dir/" \
    > >(more_verbose_echo_stdin "mv") \
    2> >(normal_echo_stderr "${RED}mv (error)")

  more_verbose_echo "${CYAN}Packaged $build_dir/$(basename "$ipa_name")${RESET}"
  PACKAGE_IOSIPA_RESULT="$build_dir/$(basename "$ipa_name")"
  return 0
}


compress_directory() {
  output="$1"
  shift
  inputs=("$@")

  if command -v 7z &>/dev/null; then
    7z a "$output" "${inputs[@]}" \
      > >(more_verbose_echo_stdin "7z") \
      2> >(normal_echo_stderr "${RED}7z (error)")
    return $?
  elif command -v zip &>/dev/null; then
    zip -r "$output" "${inputs[@]}" \
      > >(more_verbose_echo_stdin "zip") \
      2> >(normal_echo_stderr "${RED}zip (error)")
    return $?
  else
    error_echo "No suitable compression tool (7z or zip) found."
    return 127
  fi
}

rename_release_files() {
  verbose_echo "${CYAN}Moving release files to $BUILD_DIR$RESET"
  find "$BUILD_DIR/" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    dir_name=$(basename "$dir")
    more_verbose_echo "${CYAN}Found directory $dir. Looking for files...${RESET}"
    find "$dir" -maxdepth 1 -type f | while read -r file; do
      file_name=$(basename "$file")
      more_verbose_echo "${CYAN}Found file $file. Moving to $BUILD_DIR/${dir_name}_${file_name}...${RESET}"
      mv "$file" "$BUILD_DIR/${dir_name}_${file_name}"
    done
  done
}

info() {
  echo -e "${GREEN}Build TiefPrompt packages.${RESET}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: build.sh [options]${RESET}

${GREEN}-t target   ${RESET}Comma separated list of targets to build. Options:
            linux,windows,windowsmsix,androidaab,androidapk,macos,macospkg,iosipa
            (i) Can be set via environment variable 'TARGETS'
            ${RED}(!) Required${RESET}
${GREEN}-f freedom  ${RESET}Comma separated list of freedoms. Options:
            freemium,foss
            (i) Can be set via environment variable 'FREEDOM'
            ${RED}(!) Required${RESET}
${GREEN}-b dir      ${RESET}Build directory to place packages in.
            Default: /package
            (i) Unix path interpreted from current directory.
            (i) Can be set via environment variable 'BUILD_DIR'
${GREEN}-s          ${RESET}Skip Flutter preparation.
${GREEN}-d          ${RESET}Run debug build.
${GREEN}-c          ${RESET}Continue on fail.
${GREEN}-q          ${RESET}Make script quiet.
${GREEN}-v          ${RESET}Make script verbose.
${GREEN}-V          ${RESET}Make script extremely verbose (careful here!).
${GREEN}-k key      ${RESET}Signing identity for macOS code signing.
            (i) 3rd Party Mac Developer Application
            (i) Can be set via environment variable 'MACOS_CODE_SIGN_KEY'
            ${RED}(!) Required if target=macos,macospkg${RESET}
${GREEN}-K key      ${RESET}Signing identity for macOS installer signing.
            (i) 3rd Party Mac Developer Installer
            (i) Can be set via environment variable 'MACOS_PACKAGE_SIGN_KEY'
            ${RED}(!) Required if target=macospkg${RESET}
${GREEN}-p          ${RESET}Path to the Provisioning Profile for the macOS app.
            (i) Can be set via environment variable 'MACOS_PROVISIONING_PROFILE'
            ${RED}(!) Required if target=macospkg${RESET}
${GREEN}-i key      ${RESET}Signing identity for iOS installer signing.
            (i) Apple Distribution
            (i) Can be set via environment variable 'IOS_CODE_SIGN_KEY'
            ${RED}(!) Required if target=iosipa${RESET}
${GREEN}-P          ${RESET}Path to the Provisioning Profile for the iOS app.
            (i) Can be set via environment variable 'IOS_PROVISIONING_PROFILE'
            ${RED}(!) Required if target=iosipa${RESET}
${GREEN}-h          ${RESET}Show this help.
${GREEN}-E          ${RESET}Show this help and Environment Variables.
EOF
}

usage_env_vars() {
  cat <<EOF
${YELLOW}Environment Variables:${RESET}
${YELLOW}TARGETS                    ${RESET}-- -t
${YELLOW}FREEDOM                    ${RESET}-- -f
${YELLOW}BUILD_DIR                  ${RESET}-- -b
${YELLOW}MACOS_CODE_SIGN_KEY        ${RESET}-- -k
${YELLOW}MACOS_PACKAGE_SIGN_KEY     ${RESET}-- -K
${YELLOW}MACOS_PROVISIONING_PROFILE ${RESET}-- -p
${YELLOW}IOS_CODE_SIGN_KEY          ${RESET}-- -i
${YELLOW}IOS_PROVISIONING_PROFILE   ${RESET}-- -P
EOF
}
BUILD_DIR="/package"
unset -v QUIET
unset -v VERBOSE
unset -v MORE_VERBOSE
unset -v SKIP_FLUTTER_SETUP
unset -v CONTINUE_ON_FAIL
unset -v RUN_DEBUG_BUILD

while getopts "t:f:b:k:K:p:i:P:hEvVcdsq" opt; do
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
      MACOS_CODE_SIGN_KEY=$OPTARG
      ;;
    K)
      MACOS_PACKAGE_SIGN_KEY=$OPTARG
      ;;
    p)
      MACOS_PROVISIONING_PROFILE=$OPTARG
      ;;
    i)
      IOS_CODE_SIGN_KEY=$OPTARG
      ;;
    P)
      IOS_PROVISIONING_PROFILE=$OPTARG
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
    E)
      info
      usage_env_vars
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
  prepare_flutter
fi

if [ "$CONTINUE_ON_FAIL" ]; then
  set +e
fi

for freedom in $FREEDOM_LIST; do
  for target in $TARGETS_LIST; do
    verbose_echo "${YELLOW}Processing Target $target for freedom $freedom...${RESET}"

    if [ "$RUN_DEBUG_BUILD" ]; then
      configuration_upper=Debug
      configuration_lower=debug
    else
      configuration_upper=Release
      configuration_lower=release
    fi

    target_options=()
    should_compress=
    compress_path=
    case $target in
      linux)
        target_options+=(linux)
        target_results=build/linux/x64/$configuration_lower/bundle
        should_compress=YES
        compress_path="linux.zip"
        ;;
      windows)
        target_options=(windows)
        target_results=build/windows/x64/runner/$configuration_upper
        should_compress=YES
        compress_path="windows.zip"
        ;;
      windowsmsix)
        target_options=(windows)
        target_results=build/windows/x64/runner/$configuration_upper
        ;;
      androidaab)
        target_options=(appbundle)
        target_results="build/app/outputs/bundle/$configuration_lower"
        ;;
      androidapk)
        target_options=(apk --split-per-abi)
        target_results="build/app/outputs/apk/$configuration_lower"
        ;;
      macos)
        target_options=(macos)
        target_results="build/macos/Build/Products/$configuration_upper"
        should_compress=YES
        compress_path="macos.zip"
        ;;
      macospkg)
        target_options=(macos)
        target_results="build/macos/Build/Products/$configuration_upper"
        ;;
      iosipa)
        target_options=(ios --no-codesign)
        target_results="build/ios/$configuration_upper-iphoneos"
        ;;
      *)
        error_echo "Target $target could not be identified. See -h for valid targets." 1
        continue
        ;;
    esac

    if [ "$RUN_DEBUG_BUILD" ]; then
      target_options+=(--debug)
    else
      target_options+=(--release)
    fi

    case $freedom in
      freemium)
        target_options+=(-t lib/main_freemium.dart)
        ;;
      foss)
        target_options+=(-t lib/main_foss.dart)
        ;;
      *)
        error_echo "Freedom option $freedom could not be identified. See -h for valid freedom options." 1
        continue
        ;;
    esac

    more_verbose_echo "${CYAN}Building with target options: '${target_options[*]}'${RESET}"

    flutter_status=$(build_flutter "$target" "$freedom" "${target_options[@]}")
    if [ ! "$flutter_status" ]; then
      error_echo "Flutter exited with status code ${flutter_status}." "$flutter_status"
      continue
    fi

    more_verbose_echo "${CYAN}Creating scratch dir...${RESET}"
    scratch_dir=build/temp-$RANDOM
    mkdir -p "$scratch_dir"
    more_verbose_echo "${CYAN}Moving build files to scratch dir $scratch_dir...${RESET}"
    cp -R "$target_results" "$scratch_dir"
    target_results=$scratch_dir/$(basename "$target_results")
    more_verbose_echo "${CYAN}Scratch dir ready.${RESET}"

    if [ "$target" = "macos" ] || [ "$target" = "macospkg" ]; then
      sign_macos "$target_results"
    fi
    
    if [ "$target" = "iosipa" ]; then
      sign_ios "$target_results"
    fi

    more_verbose_echo "${CYAN}Finished building for target $target${RESET}"
    verbose_echo "${CYAN}Packaging Build...${RESET}"

    if [ "$target" = "macos" ]; then
      app_path=$(get_first_app "$target_results")
      more_verbose_echo "${CYAN}Copying $app_path to new directory...${RESET}"
      app_dir="$target_results/app_dir"
      mkdir -p "$app_dir" \
        > >(more_verbose_echo_stdin "mkdir") \
        2> >(normal_echo_stderr "${RED}mkdir (error)")
      cp -r "$app_path" "$app_dir" \
        > >(more_verbose_echo_stdin "cp") \
        2> >(normal_echo_stderr "${RED}cp (error)")
      target_results=$app_dir
    fi

    if [ "$target" = "windowsmsix" ]; then
      build_msix

      target_results="$target_results/*.msix"
    fi

    if [ "$target" = "macospkg" ]; then
      if ! package_macos "$target_results"; then
        error_echo "Packaging macOS Build failed" 1
        continue
      fi

      target_results="$PACKAGE_MACOS_RESULT"
    fi

    if [ "$target" = "iosipa" ]; then
      if ! package_ios_ipa "$target_results"; then
        error_echo "Packaging iOS IPA failed" 1
        continue
      fi
      target_results="$PACKAGE_IOSIPA_RESULT"
    fi

    if [ "$target" = "androidapk" ]; then
      target_results="$target_results/*.apk"
    fi

    if [ "$target" = "androidaab" ]; then
      target_results="$target_results/*.aab"
    fi

    if [ "$should_compress" ]; then
      # We need to change dir so the zip has the right structure
      pushd "$target_results" > /dev/null
      verbose_echo "${CYAN}Compressing build in $target_results to $compress_path${RESET}"
      compress_directory "$compress_path" ./*
      zip_status=$?
      # And back again
      popd > /dev/null
      if [ ! $zip_status -eq 0 ]; then
        error_echo "compression failed with exited with status code ${zip_status}." $zip_status
        continue
      fi

      target_results=$target_results/$compress_path
    fi

    verbose_echo "${CYAN}Copying $target_results to $BUILD_DIR${RESET}"
    mkdir -p "$BUILD_DIR/$freedom" \
      > >(verbose_echo_stdin "mkdir") \
      2> >(normal_echo_stderr "${RED}mkdir (error)")
    shopt -s nullglob
    # shellcheck disable=SC2206
    files=( $target_results )
    cp -r "${files[@]}" "$BUILD_DIR/$freedom" \
      > >(verbose_echo_stdin "cp") \
      2> >(normal_echo_stderr "${RED}cp (error)")
    shopt -u nullglob
    cp_status=$?
    if [ ! $cp_status -eq 0 ]; then
      error_echo "cp exited with status code ${cp_status}." $cp_status
      continue
    fi

    rename_release_files
  done
done

normal_echo "${GREEN}All builds completed successfully. Packages are available in: $BUILD_DIR${RESET}"
