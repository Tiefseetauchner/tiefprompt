#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/common.sh"

script_intfn() {
  normal_echo "${RED}Stopping Build...${NC}"
  disable_iap
}

prepare_flutter() {
  verbose_echo "${CYAN}Setting .flutter to be a safe git directory${NC}"
  git config --global --add safe.directory "$(pwd)/.flutter" \
    > >(verbose_echo_stdin "git") \
    2> >(error_echo_stderr "git")
  verbose_echo "${CYAN}Disabling flutter analytics...${NC}"
  .flutter/bin/flutter --disable-analytics \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter")
  verbose_echo "${CYAN}Disabling flutter cli animations...${NC}"
  .flutter/bin/flutter config --no-cli-animations \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter")
  verbose_echo "${CYAN}Checking and preparing flutter...${NC}"
  .flutter/bin/flutter doctor \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter")
  verbose_echo "${CYAN}Cleaning with flutter...${NC}"
  .flutter/bin/flutter clean \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter")
  verbose_echo "${CYAN}Getting flutter packages...${NC}"
  .flutter/bin/flutter pub get \
    > >(more_verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter")
}

build_flutter() {
  normal_echo "${GREEN}Building for target $1 and freedom $2...${NC}"
  shift 2
  flutter_args=("$@")
  env "${extra_env[@]}" .flutter/bin/flutter build "${flutter_args[@]}" \
    > >(verbose_echo_stdin "flutter") \
    2> >(error_echo_stderr "flutter")
  return $?
}

build_msix() {
  verbose_echo "${CYAN}Creating MSIX package...${NC}"
  .flutter/bin/flutter pub run msix:create --install-certificate false  \
    > >(verbose_echo_stdin "msix") \
    2> >(error_echo_stderr "msix")
  msix_status=$?
  if [ ! $msix_status -eq 0 ]; then
    error_echo "MSIX packaging failed with status code ${msix_status}." "$CONTINUE_ON_FAIL" $msix_status
  fi
  target_results="build/windows/x64/runner/Release/*.msix"
}

get_first_app() {
  find "$1" -type d -iname "*.app" | head -n 1
}

sign_macos() {
  if [ -z "$MACOS_CODE_SIGN_KEY" ]; then
    error_echo "-k must be set if building macOS to sign the binaries." "$CONTINUE_ON_FAIL" 127
    return 127
  fi

  app_name=$(get_first_app "$1")

  xattr -rc "$app_name"

  if [ -n "$MACOS_PROVISIONING_PROFILE" ]; then
    verbose_echo "${CYAN}Embedding provisioning profile...${NC}"
    cp "$MACOS_PROVISIONING_PROFILE" "$app_name/Contents/embedded.provisionprofile" \
      > >(verbose_echo_stdin "cp provisionprofile") \
      2> >(error_echo_stderr "cp provisionprofile")
    # Remove quarantine from the copy — source file may have been downloaded
    xattr -d com.apple.quarantine "$app_name/Contents/embedded.provisionprofile" 2>/dev/null || true
  fi

  verbose_echo "${CYAN}Fixing framework symlinks...${NC}"
  find "$app_name/Contents/Frameworks" -maxdepth 1 -type d -name "*.framework" | while read -r framework; do
    name=$(basename "$framework" .framework)
    if [ -d "$framework/Versions/A" ]; then
      # Versions/Current -> A (Flutter build leaves this as a broken placeholder)
      rm -f "$framework/Versions/Current"
      ln -s A "$framework/Versions/Current"
    fi
    # Top-level binary symlink: <name> -> Versions/Current/<name>
    if [ -e "$framework/Versions/A/$name" ]; then
      rm -f "$framework/$name"
      ln -s "Versions/Current/$name" "$framework/$name"
    fi
    # Top-level Resources symlink: Resources -> Versions/Current/Resources
    if [ -d "$framework/Versions/A/Resources" ]; then
      rm -f "$framework/Resources"
      ln -s "Versions/Current/Resources" "$framework/Resources"
    fi
  done

  verbose_echo "${CYAN}Signing nested binaries...${NC}"
  while IFS= read -r bin; do
    verbose_echo "${CYAN}Signing nested binary: $bin${NC}"
    codesign --force --verify --verbose --timestamp \
      --sign "$MACOS_CODE_SIGN_KEY" "$bin" \
      > >(verbose_echo_stdin "codesign (nested)") \
      2> >(error_echo_stderr "codesign (nested error)")
  done < <(find "$app_name/Contents/Frameworks" -type f \( -name "*.dylib" -o -name "*.so" -o -perm -111 \))

  verbose_echo "${CYAN}Signing framework bundles...${NC}"
  while IFS= read -r framework; do
    verbose_echo "${CYAN}Signing framework: $framework${NC}"
    codesign --force --verify --verbose --timestamp \
      --sign "$MACOS_CODE_SIGN_KEY" "$framework" \
      > >(verbose_echo_stdin "codesign (framework)") \
      2> >(error_echo_stderr "codesign (framework error)")
  done < <(find "$app_name/Contents/Frameworks" -maxdepth 1 -type d -name "*.framework")

  if [ -n "$MACOS_PROVISIONING_PROFILE" ]; then
    entitlements_plist="$(dirname "$app_name")/entitlements.plist"
    security cms -D -i "$MACOS_PROVISIONING_PROFILE" 2>/dev/null |
      plutil -extract Entitlements xml1 -o "$entitlements_plist" -
    # Profiles for Mac App Store often omit app-sandbox — force it on
    /usr/libexec/PlistBuddy -c "Add :com.apple.security.app-sandbox bool true" "$entitlements_plist" 2>/dev/null || \
      /usr/libexec/PlistBuddy -c "Set :com.apple.security.app-sandbox true" "$entitlements_plist"
    # Ensure file picker access — file_picker checks for this at runtime
    /usr/libexec/PlistBuddy -c "Add :com.apple.security.files.user-selected.read-only bool true" "$entitlements_plist" 2>/dev/null || \
      /usr/libexec/PlistBuddy -c "Set :com.apple.security.files.user-selected.read-only true" "$entitlements_plist"
    verbose_echo "${CYAN}Using entitlements from provisioning profile (sandbox enforced)${NC}"
  else
    entitlements_plist="macos/Runner/Release.entitlements"
  fi

  codesign --force --verify --verbose --timestamp --options runtime \
    --entitlements "$entitlements_plist" \
    --sign "$MACOS_CODE_SIGN_KEY" "$app_name" \
    > >(verbose_echo_stdin "codesign (main app)") \
    2> >(error_echo_stderr "codesign (main app error)")
  codesign_status=$?
  if [ ! $codesign_status -eq 0 ]; then
    error_echo "codesign failed with status code ${codesign_status}." "$CONTINUE_ON_FAIL" $codesign_status
  fi
}

package_macos() {
  app_name=$(get_first_app "$1")
  base_name=$(dirname "$app_name")/$(basename "$app_name" .app)

  if [ -z "$MACOS_PACKAGE_SIGN_KEY" ]; then
    error_echo "-K must be set if building macOS packages to sign the pkg." "$CONTINUE_ON_FAIL" 127
    return 127
  fi

  more_verbose_echo "${CYAN}Creating macOS pkg...${NC}"
  productbuild --component "$app_name" /Applications \
    --sign "$MACOS_PACKAGE_SIGN_KEY" \
    "${base_name}.pkg" \
    > >(more_verbose_echo_stdin "productbuild") \
    2> >(error_echo_stderr "productbuild")


  PACKAGE_MACOS_RESULT="${base_name}.pkg"

  return 0
}

notarize_macos_pkg() {
  if [ ! "$ENABLE_MACOS_NOTARIZATION" ]; then
    return 0
  fi

  pkg_path="$1"

  if [ -z "$pkg_path" ]; then
    error_echo "notarize_macos_pkg: package path missing." "$CONTINUE_ON_FAIL" 127
    return 127
  fi
  if [ ! -f "$pkg_path" ]; then
    error_echo "notarize_macos_pkg: $pkg_path does not exist." "$CONTINUE_ON_FAIL" 127
    return 127
  fi

  cred_args=()
  if [ "$AC_API_KEY_ID" ] && [ "$AC_API_KEY_ISSUER" ] && [ "$AC_API_PRIVATE_KEY" ]; then
    cred_args+=(--key "$AC_API_PRIVATE_KEY" --key-id "$AC_API_KEY_ID" --issuer "$AC_API_KEY_ISSUER")
  elif [ "$APPLE_ID" ] && [ "$APPLE_ID_PASSWORD" ]; then
    cred_args+=(--apple-id "$APPLE_ID" --password "$APPLE_ID_PASSWORD")
  else
    verbose_echo "${YELLOW}Skipping notarization: no credentials provided (AC_API_* or APPLE_ID).${NC}"
    return 0
  fi

  verbose_echo "${CYAN}Submitting $pkg_path for notarization...${NC}"
  xcrun notarytool submit "$pkg_path" "${cred_args[@]}" --wait \
    > >(verbose_echo_stdin "notarytool") \
    2> >(error_echo_stderr "notarytool")
  submit_status=$?
  if [ ! $submit_status -eq 0 ]; then
    error_echo "Notarization failed with status code ${submit_status}." "$CONTINUE_ON_FAIL" $submit_status
    return 127
  fi

  verbose_echo "${CYAN}Stapling notarization ticket...${NC}"
  xcrun stapler staple "$pkg_path" \
    > >(verbose_echo_stdin "stapler") \
    2> >(error_echo_stderr "stapler")
  staple_status=$?
  if [ ! $staple_status -eq 0 ]; then
    error_echo "Stapling failed with status code ${staple_status}." "$CONTINUE_ON_FAIL" $staple_status
    return 127
  fi

  return 0
}

notarize_macos_app() {
  if [ ! "$ENABLE_MACOS_NOTARIZATION" ]; then
    return 0
  fi

  app_path="$1"

  if [ -z "$app_path" ]; then
    error_echo "notarize_macos_app: app path missing." "$CONTINUE_ON_FAIL" 127
    return 127
  fi
  if [ ! -d "$app_path" ]; then
    error_echo "notarize_macos_app: $app_path does not exist." "$CONTINUE_ON_FAIL" 127
    return 127
  fi

  cred_args=()
  if [ "$AC_API_KEY_ID" ] && [ "$AC_API_KEY_ISSUER" ] && [ "$AC_API_PRIVATE_KEY" ]; then
    cred_args+=(--key "$AC_API_PRIVATE_KEY" --key-id "$AC_API_KEY_ID" --issuer "$AC_API_KEY_ISSUER")
  elif [ "$APPLE_ID" ] && [ "$APPLE_ID_PASSWORD" ]; then
    cred_args+=(--apple-id "$APPLE_ID" --password "$APPLE_ID_PASSWORD")
  else
    verbose_echo "${YELLOW}Skipping notarization: no credentials provided (AC_API_* or APPLE_ID).${NC}"
    return 0
  fi

  zip_path="${app_path%.app}.notarize.zip"
  verbose_echo "${CYAN}Zipping $app_path for notarization submission...${NC}"
  ditto -c -k --keepParent "$app_path" "$zip_path" \
    > >(verbose_echo_stdin "ditto") \
    2> >(error_echo_stderr "ditto")

  verbose_echo "${CYAN}Submitting $app_path for notarization...${NC}"
  xcrun notarytool submit "$zip_path" "${cred_args[@]}" --wait \
    > >(verbose_echo_stdin "notarytool") \
    2> >(error_echo_stderr "notarytool")
  submit_status=$?
  rm -f "$zip_path"
  if [ ! $submit_status -eq 0 ]; then
    error_echo "App notarization failed with status code ${submit_status}." "$CONTINUE_ON_FAIL" $submit_status
    return 127
  fi

  verbose_echo "${CYAN}Stapling notarization ticket to $app_path...${NC}"
  xcrun stapler staple "$app_path" \
    > >(verbose_echo_stdin "stapler") \
    2> >(error_echo_stderr "stapler")
  staple_status=$?
  if [ ! $staple_status -eq 0 ]; then
    error_echo "App stapling failed with status code ${staple_status}." "$CONTINUE_ON_FAIL" $staple_status
    return 127
  fi

  return 0
}

add_ios_swiftsupport() {
  more_verbose_echo "${CYAN}Adding iOS SwiftSupport Folder${NC}"

  app_path=$(find "$1" -name "*.app" -maxdepth 1)

  dylibs=()
  while IFS= read -r -d '' lib; do
    dylibs+=("$lib")
  done < <(find "$app_path/Frameworks" -type f -name "*.dylib" -print0 2>/dev/null)
  if [ ${#dylibs[@]} -eq 0 ]; then
    more_verbose_echo "${CYAN}No Swift dylibs found, skipping SwiftSupport folder${NC}"
    return 0
  fi

  mkdir -p "$2/SwiftSupport/iphoneos" \
    > >(more_verbose_echo_stdin "mkdir") \
    2> >(error_echo_stderr "mkdir")
  for lib in "${dylibs[@]}"; do
    cp "$lib" "$2/SwiftSupport/iphoneos" \
      > >(more_verbose_echo_stdin "cp") \
      2> >(error_echo_stderr "cp")
  done
}


sign_ios() {
  if [ -z "$IOS_CODE_SIGN_KEY" ]; then
    error_echo "-i must be set to sign the .app." "$CONTINUE_ON_FAIL" 127
    return 127
  fi

  if [ -z "$IOS_PROVISIONING_PROFILE" ]; then
    error_echo "-P must be set to embed the profile." "$CONTINUE_ON_FAIL" 127
    return 127
  fi

  app_path=$(find "$1" -name "*.app" -maxdepth 1)

  cp "$IOS_PROVISIONING_PROFILE" "$app_path/embedded.mobileprovision" \
    > >(verbose_echo_stdin "cp mobileprovision") \
    2> >(error_echo_stderr "cp mobileprovision")

  entitlements_plist=$1/entitlements.plist
  security cms -D -i "$IOS_PROVISIONING_PROFILE" 2>/dev/null |
    plutil -extract Entitlements xml1 -o - - >"$entitlements_plist"

  xattr -rc "$app_path"

  if [ -d "$app_path/Frameworks" ]; then
    find "$app_path/Frameworks" -type d -name "*.framework" | while read -r framework; do
      codesign --force --timestamp --sign "$IOS_CODE_SIGN_KEY" --preserve-metadata=identifier,entitlements "$framework" \
        > >(verbose_echo_stdin "codesign") \
        2> >(error_echo_stderr "codesign")
    done
  fi

  codesign --force --timestamp --sign "$IOS_CODE_SIGN_KEY" --entitlements "$entitlements_plist" "$app_path" \
    > >(verbose_echo_stdin "codesign") \
    2> >(error_echo_stderr "codesign")
}

package_ios_ipa() {
  build_dir="$1"
  app_path=$(find "$build_dir" -maxdepth 1 -name "*.app" -type d)

  ipa_name="$(basename "${app_path%.app}.ipa")"
  tmpdir=$build_dir/ipa_temp
  add_ios_swiftsupport "$target_results" "$tmpdir/" 
  more_verbose_echo "${CYAN}Creating temp dir $tmpdir/Payload${NC}"
  mkdir -p "$tmpdir" \
    > >(more_verbose_echo_stdin "mkdir") \
    2> >(error_echo_stderr "mkdir")
  mkdir -p "$tmpdir/Payload" \
    > >(more_verbose_echo_stdin "mkdir") \
    2> >(error_echo_stderr "mkdir")
  more_verbose_echo "${CYAN}Copying $app_path to $tmpdir/Payload${NC}"
  cp -R "$app_path" "$tmpdir/Payload/" \
    > >(more_verbose_echo_stdin "cp") \
    2> >(error_echo_stderr "cp")
  more_verbose_echo "${CYAN}Zipping $tmpdir/ to $ipa_name${NC}"
  (cd "$tmpdir" && \
    zip -r "$ipa_name" . \
      > >(more_verbose_echo_stdin "zip") \
      2> >(error_echo_stderr "zip"))
  mv "$tmpdir/$ipa_name" "$build_dir/" \
    > >(more_verbose_echo_stdin "mv") \
    2> >(error_echo_stderr "mv")

  more_verbose_echo "${CYAN}Packaged $build_dir/$(basename "$ipa_name")${NC}"
  PACKAGE_IOSIPA_RESULT="$build_dir/$(basename "$ipa_name")"
  return 0
}


compress_directory() {
  output="$1"
  shift
  inputs=("$@")

  if command -v ditto &>/dev/null && [ ${#inputs[@]} -eq 1 ]; then
    ditto -c -k --keepParent "${inputs[0]}" "$output" \
      > >(more_verbose_echo_stdin "ditto") \
      2> >(error_echo_stderr "ditto")
    return $?
  elif command -v 7z &>/dev/null; then
    7z a "$output" "${inputs[@]}" \
      > >(more_verbose_echo_stdin "7z") \
      2> >(error_echo_stderr "7z")
    return $?
  elif command -v zip &>/dev/null; then
    zip -r "$output" "${inputs[@]}" \
      > >(more_verbose_echo_stdin "zip") \
      2> >(error_echo_stderr "zip")
    return $?
  else
    error_echo "No suitable compression tool (ditto, 7z, or zip) found." "$CONTINUE_ON_FAIL" 127
  fi
}

rename_release_files() {
  verbose_echo "${CYAN}Moving release files to $BUILD_DIR$NC"
  find "$BUILD_DIR/" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
    dir_name=$(basename "$dir")
    more_verbose_echo "${CYAN}Found directory $dir. Looking for files...${NC}"
    find "$dir" -maxdepth 1 -type f | while read -r file; do
      file_name=$(basename "$file")
      more_verbose_echo "${CYAN}Found file $file. Moving to $BUILD_DIR/${dir_name}_${file_name}...${NC}"
      mv "$file" "$BUILD_DIR/${dir_name}_${file_name}"
    done
  done
}

info() {
  echo -e "${GREEN}Build TiefPrompt packages.${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: build.sh [options]${NC}

${GREEN}-t target   ${NC}Comma separated list of targets to build. Options:
            linux,windows,windowsmsix,androidaab,androidapk,macos,macospkg,iosipa
            (i) Can be set via environment variable 'TARGETS'
            ${RED}(!) Required${NC}
${GREEN}-f freedom  ${NC}Comma separated list of freedoms. Options:
            freemium,foss
            (i) Can be set via environment variable 'FREEDOM'
            ${RED}(!) Required${NC}
${GREEN}-b dir      ${NC}Build directory to place packages in.
            Default: /package
            (i) Unix path interpreted from current directory.
            (i) Can be set via environment variable 'BUILD_DIR'
${GREEN}-s          ${NC}Skip Flutter preparation.
${GREEN}-d          ${NC}Run debug build.
${GREEN}-c          ${NC}Continue on fail.
${GREEN}-k key      ${NC}Signing identity for macOS code signing.
            (i) 3rd Party Mac Developer Application
            (i) Can be set via environment variable 'MACOS_CODE_SIGN_KEY'
            ${RED}(!) Required if target=macos,macospkg and -N not set${NC}
${GREEN}-K key      ${NC}Signing identity for macOS installer signing.
            (i) 3rd Party Mac Developer Installer
            (i) Can be set via environment variable 'MACOS_PACKAGE_SIGN_KEY'
            ${RED}(!) Required if target=macospkg${NC}
${GREEN}-p          ${NC}Path to the Provisioning Profile for the macOS app.
            (i) Can be set via environment variable 'MACOS_PROVISIONING_PROFILE'
            ${RED}(!) Required if target=macospkg${NC}
${GREEN}-n          ${NC}Enable macOS notarization for macOS packages.
${GREEN}-N          ${NC}Disable macOS code signing.
${GREEN}-i key      ${NC}Signing identity for iOS installer signing.
            (i) Apple Distribution
            (i) Can be set via environment variable 'IOS_CODE_SIGN_KEY'
            ${RED}(!) Required if target=iosipa${NC}
${GREEN}-P          ${NC}Path to the Provisioning Profile for the iOS app.
            (i) Can be set via environment variable 'IOS_PROVISIONING_PROFILE'
            ${RED}(!) Required if target=iosipa${NC}
EOF

  help_common_params

  cat <<EOF
${GREEN}-E          ${NC}Show this help and Environment Variables.
EOF
}

usage_env_vars() {
  cat <<EOF
${YELLOW}Environment Variables:${NC}
${YELLOW}TARGETS                    ${NC}-- -t
${YELLOW}FREEDOM                    ${NC}-- -f
${YELLOW}BUILD_DIR                  ${NC}-- -b
${YELLOW}MACOS_CODE_SIGN_KEY        ${NC}-- -k
${YELLOW}MACOS_PACKAGE_SIGN_KEY     ${NC}-- -K
${YELLOW}MACOS_PROVISIONING_PROFILE ${NC}-- -p
${YELLOW}IOS_CODE_SIGN_KEY          ${NC}-- -i
${YELLOW}IOS_PROVISIONING_PROFILE   ${NC}-- -P
EOF
}
BUILD_DIR="/package"
unset -v QUIET
unset -v VERBOSE
unset -v MORE_VERBOSE
unset -v SKIP_FLUTTER_SETUP
unset -v CONTINUE_ON_FAIL
unset -v RUN_DEBUG_BUILD
unset -v ENABLE_MACOS_NOTARIZATION

while getopts "t:f:b:k:K:p:i:P:EcdsnN${COMMON_PARAMS}" opt; do
  if [[ "$COMMON_PARAMS" == *"$opt"* ]]; then
    parse_common_params "$opt" "$OPTARG"
    continue
  fi

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
    c)
      CONTINUE_ON_FAIL=YES
      ;;
    d)
      RUN_DEBUG_BUILD=YES
      ;;
    n)
      ENABLE_MACOS_NOTARIZATION=YES
      ;;
    s)
      SKIP_FLUTTER_SETUP=YES
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
  error_echo "-t (targets) and -f (freedom) must be set to run this script." "$CONTINUE_ON_FAIL" 1
fi

TARGETS_LIST=$(echo "$TARGETS" | tr ',' ' ')
FREEDOM_LIST=$(echo "$FREEDOM" | tr ',' ' ')

normal_echo "${CYAN}Building Flutter applications...${NC}"

if [ -z "$SKIP_FLUTTER_SETUP" ]; then
  prepare_flutter
fi

if [ "$CONTINUE_ON_FAIL" ]; then
  set +e
fi

for freedom in $FREEDOM_LIST; do
  for target in $TARGETS_LIST; do
    verbose_echo "${YELLOW}Processing Target $target for freedom $freedom...${NC}"

    if [ "$RUN_DEBUG_BUILD" ]; then
      configuration_upper=Debug
      configuration_lower=debug
    else
      configuration_upper=Release
      configuration_lower=release
    fi

    target_options=()
    extra_env=()
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
        extra_env=("FLUTTER_XCODE_CODE_SIGNING_REQUIRED=NO" "FLUTTER_XCODE_CODE_SIGN_IDENTITY=" "FLUTTER_XCODE_CODE_SIGNING_ALLOWED=NO")
        ;;
      macospkg)
        target_options=(macos)
        target_results="build/macos/Build/Products/$configuration_upper"
        extra_env=("FLUTTER_XCODE_CODE_SIGNING_REQUIRED=NO" "FLUTTER_XCODE_CODE_SIGN_IDENTITY=" "FLUTTER_XCODE_CODE_SIGNING_ALLOWED=NO")
        ;;
      iosipa)
        target_options=(ios --no-codesign)
        target_results="build/ios/$configuration_upper-iphoneos"
        ;;
      *)
        error_echo "Target $target could not be identified. See -h for valid targets." "$CONTINUE_ON_FAIL" 1
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
        enable_iap
        target_options+=(-t lib/main_freemium.dart)
        ;;
      foss)
        target_options+=(-t lib/main_foss.dart)
        ;;
      *)
        error_echo "Freedom option $freedom could not be identified. See -h for valid freedom options." "$CONTINUE_ON_FAIL" 1
        continue
        ;;
    esac

    more_verbose_echo "${CYAN}Building with target options: '${target_options[*]}'${NC}"

    if [ ! "$target" = "windowsmsix" ]; then
      flutter_status=0
      build_flutter "$target" "$freedom" "${target_options[@]}" || flutter_status=$?
      if [ $flutter_status -ne 0 ]; then
        error_echo "Flutter exited with status code ${flutter_status}." "$CONTINUE_ON_FAIL" "$flutter_status"
        continue
      fi
    fi

    more_verbose_echo "${CYAN}Creating scratch dir...${NC}"
    scratch_dir=build/temp-$RANDOM
    mkdir -p "$scratch_dir"
    more_verbose_echo "${CYAN}Moving build files to scratch dir $scratch_dir...${NC}"
    cp -R "$target_results" "$scratch_dir"
    target_results=$scratch_dir/$(basename "$target_results")
    more_verbose_echo "${CYAN}Scratch dir ready.${NC}"

    if [ "$target" = "macos" ] || [ "$target" = "macospkg" ]; then
      sign_macos "$target_results"
    fi

    if [ "$target" = "iosipa" ]; then
      sign_ios "$target_results"
    fi

    more_verbose_echo "${CYAN}Finished building for target $target${NC}"
    verbose_echo "${CYAN}Packaging Build...${NC}"

    if [ "$target" = "macos" ]; then
      app_path=$(get_first_app "$target_results")

      if ! notarize_macos_app "$app_path"; then
        error_echo "Notarizing macOS App failed" "$CONTINUE_ON_FAIL" 1
        continue
      fi

      more_verbose_echo "${CYAN}Copying $app_path to new directory...${NC}"
      app_dir="$target_results/app_dir"
      mkdir -p "$app_dir" \
        > >(more_verbose_echo_stdin "mkdir") \
        2> >(error_echo_stderr "mkdir")
      cp -r "$app_path" "$app_dir" \
        > >(more_verbose_echo_stdin "cp") \
        2> >(error_echo_stderr "cp")
      target_results=$app_dir
    fi

    if [ "$target" = "windowsmsix" ]; then
      build_msix
    fi

    if [ "$target" = "macospkg" ]; then
      if ! package_macos "$target_results"; then
        error_echo "Packaging macOS Build failed" "$CONTINUE_ON_FAIL" 1
        continue
      fi

      target_results="$PACKAGE_MACOS_RESULT"

      if ! notarize_macos_pkg "$target_results"; then
        error_echo "Notarizing macOS Build failed" "$CONTINUE_ON_FAIL" 1
        continue
      fi
    fi

    if [ "$target" = "iosipa" ]; then
      if ! package_ios_ipa "$target_results"; then
        error_echo "Packaging iOS IPA failed" "$CONTINUE_ON_FAIL" 1
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
      verbose_echo "${CYAN}Compressing build in $target_results to $compress_path${NC}"
      compress_directory "$compress_path" ./*
      zip_status=$?
      # And back again
      popd > /dev/null
      if [ ! $zip_status -eq 0 ]; then
        error_echo "compression failed with exited with status code ${zip_status}." "$CONTINUE_ON_FAIL" $zip_status
        continue
      fi

      target_results=$target_results/$compress_path
    fi

    if [ "$freedom" = "freemium" ]; then
      disable_iap
    fi

    verbose_echo "${CYAN}Copying $target_results to $BUILD_DIR${NC}"
    mkdir -p "$BUILD_DIR/$freedom" \
      > >(verbose_echo_stdin "mkdir") \
      2> >(error_echo_stderr "mkdir")
    shopt -s nullglob
    # shellcheck disable=SC2206
    files=( $target_results )
    cp -r "${files[@]}" "$BUILD_DIR/$freedom" \
      > >(verbose_echo_stdin "cp") \
      2> >(error_echo_stderr "cp")
    shopt -u nullglob
    cp_status=$?
    if [ ! $cp_status -eq 0 ]; then
      error_echo "cp exited with status code ${cp_status}." "$CONTINUE_ON_FAIL" $cp_status
      continue
    fi

    rename_release_files
  done
done

normal_echo "${GREEN}All builds completed successfully. Packages are available in: $BUILD_DIR${NC}"
