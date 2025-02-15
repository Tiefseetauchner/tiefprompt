#!/bin/bash

PACKAGE_DIR=$(dirname "$0")/../package/

# Define colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}Creating package directory: $PACKAGE_DIR${RESET}"
mkdir -p "$PACKAGE_DIR"
rm -rf "$PACKAGE_DIR"/*

echo -e "${YELLOW}Building AAB (Android App Bundle)...${RESET}"
flutter build appbundle --release
if [ $? -eq 0 ]; then
  echo -e "${GREEN}AAB build successful. Copying to package directory...${RESET}"
  cp build/app/outputs/bundle/release/app-release.aab "$PACKAGE_DIR"
else
  echo -e "${RED}AAB build failed.${RESET}"
  exit 1
fi

echo -e "${YELLOW}Building APK...${RESET}"
flutter build apk --release
if [ $? -eq 0 ]; then
  echo -e "${GREEN}APK build successful. Copying to package directory...${RESET}"
  cp build/app/outputs/apk/release/app-release.apk "$PACKAGE_DIR"
else
  echo -e "${RED}APK build failed.${RESET}"
  exit 1
fi

echo -e "${YELLOW}Building Linux application...${RESET}"
flutter build linux --release
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Linux build successful. Creating package archive...${RESET}"
  tar -czvf "$PACKAGE_DIR/tiefprompt_linux.tar.gz" build/linux/x64/release/bundle
else
  echo -e "${RED}Linux build failed.${RESET}"
  exit 1
fi

echo -e "${GREEN}All builds completed successfully. Packages are available in: $PACKAGE_DIR${RESET}"
