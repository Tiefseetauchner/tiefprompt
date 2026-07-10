#!/usr/bin/env bash

set -euo pipefail

source tools/common.sh

ok() {
  normal_echo "${GREEN}(/) $1${NC}"
}

info() {
  echo -e "${GREEN}Run release checks and prepare release${NC}"

  usage
}

usage() {
  cat <<EOF
${YELLOW}usage: release.sh [options]${NC}
EOF
  
  help_common_params
}

PUBSPEC="pubspec.yaml"

version_line="$(grep -E '^version:' "$PUBSPEC" | head -n1)"
[ -n "$version_line" ] || error_echo "Could not find a 'version:' line in $PUBSPEC."
verbose_echo "${CYAN}Parsed version line: ${version_line}${NC}"

version_string="$(echo "${version_line#version:}" | tr -d '[:space:]')"
version_number="${version_string%%+*}"
build_number="${version_string#*+}"

[ "$version_number" != "$version_string" ] || error_echo "Version '$version_string' has no build number (expected name+build)."
[ -n "$build_number" ] || error_echo "Could not parse build number from '$version_string'."
ok "Version: $version_number (build $build_number)"

case "$version_number" in
  *-*) error_echo "Version '$version_number' is a pre-release (contains '-'). Bump to a release version first." ;;
esac
ok "Version number is a release version"

metadata_changelog="metadata/en-US/changelogs/${build_number}4.txt"
[ -f "$metadata_changelog" ] || error_echo "Missing store changelog: $metadata_changelog"
ok "Store changelog present: $metadata_changelog"

required_changelog_locales=("en-US" "de-DE")
for locale in "${required_changelog_locales[@]}"; do
  asset_changelog="assets/changelogs/${locale}/${version_number}.md"
  [ -f "$asset_changelog" ] || error_echo "Missing in-app changelog: $asset_changelog"
  ok "In-app changelog present: $asset_changelog"
done

for dir in assets/changelogs/*/; do
  [ -d "$dir" ] || continue
  asset_entry="${dir%/}/"
  if ! grep -qF -- "- $asset_entry" "$PUBSPEC"; then
    # Insert after the last existing entry so the changelog assets stay grouped.
    last_line="$(grep -nF -- "- assets/changelogs/" "$PUBSPEC" | tail -n1 | cut -d: -f1)"
    [ -n "$last_line" ] || error_echo "No existing 'assets/changelogs/' entries in $PUBSPEC to anchor insertion."
    indent="$(grep -F -- "- assets/changelogs/" "$PUBSPEC" | head -n1 | sed -E 's/-.*//')"
    verbose_echo "${CYAN}Inserting '${asset_entry}' after line ${last_line} of ${PUBSPEC}${NC}"
    sed -i "${last_line}a\\${indent}- ${asset_entry}" "$PUBSPEC"
    ok "Registered missing asset dir in $PUBSPEC: $asset_entry"
  fi
done
ok "All changelog asset directories are registered"

tag="v${version_number}"
[ -z "$(git tag -l "$tag")" ] || error_echo "Tag '$tag' already exists."
ok "Tag '$tag' does not exist yet"

if grep -qE '^[[:space:]]*in_app_purchase(_android)?[[:space:]]*:' "$PUBSPEC"; then
  error_echo "in_app_purchase / in_app_purchase_android must be commented out for a FOSS release."
fi
ok "In-app purchase dependencies are commented out"

normal_echo "${CYAN}Building FOSS flavor (flutter build linux --target lib/main_foss.dart)...${NC}"
flutter_status=0
flutter build linux --target lib/main_foss.dart \
  > >(verbose_echo_stdin "flutter") \
  2> >(error_echo_stderr "flutter (error)") || flutter_status=$?
[ "$flutter_status" -eq 0 ] || error_echo "FOSS build failed with status code ${flutter_status}." "$flutter_status"
ok "FOSS build succeeded"

verbose_echo "${CYAN}Tagging: git tag ${tag}${NC}"
git tag "$tag"
ok "Created tag '$tag'"

normal_echo ""
normal_echo "Done. To publish the release, run:"
normal_echo "    git push origin $tag"
