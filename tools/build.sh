#!/bin/bash
set -e

BUILD_DIR="/package"

# Define colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}Building Flutter applications inside container...${RESET}"

git config --global --add safe.directory /app/.flutter

# Ensure Flutter dependencies are up-to-date
flutter --disable-analytics
flutter config --no-cli-animations
flutter doctor
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

echo -e "${GREEN}All builds completed successfully. Packages are available in: $BUILD_DIR${RESET}"
