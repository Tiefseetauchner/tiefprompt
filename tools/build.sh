#!/bin/bash
set -e

BUILD_DIR="./package"

# Define colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}Building Flutter applications inside container...${RESET}"

# Ensure Flutter dependencies are up-to-date
flutter --disable-analytics
flutter config --no-cli-animations
flutter clean
flutter pub get

# Build AAB
echo -e "${YELLOW}Building AAB (Android App Bundle)...${RESET}"
flutter build appbundle --release
cp build/app/outputs/bundle/release/app* "$BUILD_DIR"

# Build APK
echo -e "${YELLOW}Building APK...${RESET}"
flutter build apk --release --split-per-abi
cp build/app/outputs/apk/release/app* "$BUILD_DIR"

# Build Linux
echo -e "${YELLOW}Building Linux application...${RESET}"
flutter build linux --release
tar -czvf "$BUILD_DIR/tiefprompt_linux.tar.gz" build/linux/x64/release/bundle

echo -e "${GREEN}All builds completed successfully. Packages are available in: $BUILD_DIR${RESET}"
