#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
# generate-delta-package.sh
# Generates a delta deployment package using sfdx-git-delta (SGD).
# Compares HEAD against the base branch to find only changed metadata.
#
# Required env vars:
#   BASE_BRANCH   — branch to diff against (e.g. "main" or "develop")
#   API_VERSION   — Salesforce API version (e.g. "59.0")
#
# Usage:
#   BASE_BRANCH=main API_VERSION=59.0 ./scripts/generate-delta-package.sh
# ─────────────────────────────────────────────────────────────────────

set -euo pipefail

BASE_BRANCH="${BASE_BRANCH}"
API_VERSION="${API_VERSION:-59.0}"
OUTPUT_DIR="./delta-package"
IGNORE_FILE="manifest/.sgdignore"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Generating delta package"
echo " Base branch : origin/$BASE_BRANCH"
echo " API version : $API_VERSION"
echo " Output dir  : $OUTPUT_DIR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── Create output directories ───────────────────────────────────────
mkdir -p "$OUTPUT_DIR"

# ── Run SGD ─────────────────────────────────────────────────────────
sf sgd source delta \
  --from "origin/$BASE_BRANCH" \
  --output-dir "$OUTPUT_DIR" \
  --ignore-file "$IGNORE_FILE"

# ── Show what was generated ─────────────────────────────────────────
echo ""
echo "--- package.xml (added / modified metadata) ---"
cat "$OUTPUT_DIR/package/package.xml"

echo ""
echo "--- destructiveChanges.xml (deleted metadata) ---"
cat "$OUTPUT_DIR/destructiveChanges/destructiveChanges.xml"

# ── Guard: check if package is empty ────────────────────────────────
# If no types are present, downstream deploy steps should be skipped.
if grep -q "<types>" "$OUTPUT_DIR/package/package.xml"; then
  echo ""
  echo "✅  Delta package has changes — ready to deploy."
  echo "DELTA_HAS_CHANGES=true" >> "${GITHUB_ENV:-/dev/null}"
else
  echo ""
  echo "⚠️   No metadata changes detected in delta package."
  echo "DELTA_HAS_CHANGES=false" >> "${GITHUB_ENV:-/dev/null}"
fi