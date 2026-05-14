#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
# scanner.sh
# Runs Salesforce Code Analyzer v5 (sf code-analyzer) against the
# force-app source. Fails the pipeline if violations are found at
# or above the severity threshold.
#
# Severity levels: 1 = Critical, 2 = High, 3 = Moderate, 4 = Low
#
# Usage:
#   ./scripts/scanner.sh
# ─────────────────────────────────────────────────────────────────────

set -euo pipefail

TARGET="force-app/**"
OUTPUT_DIR="./scanner-results"
SEVERITY_THRESHOLD=3        # fail on Critical, High, Moderate and above

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Salesforce Code Analyzer v5"
echo " Target     : $TARGET"
echo " Fail on    : severity <= $SEVERITY_THRESHOLD"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

mkdir -p "$OUTPUT_DIR"

# ── Install the plugin if not already present ──────────────────────
# The `|| true` prevents set -e from exiting if it's already installed
sf plugins install @salesforce/cli-plugin-code-analyzer || true

# ── Run the scanner ────────────────────────────────────────────────
# --rule-selector selects engines/categories
# --severity-threshold fails the command (exit 1) if violations found
# --output-file writes a machine-readable report for artifact upload
sf code-analyzer run \
  --target               "$TARGET" \
  --rule-selector        "all" \
  --output-format        table \
  --output-file          "$OUTPUT_DIR/scan-results.html" \
  --severity-threshold   $SEVERITY_THRESHOLD

echo ""
echo "✅  Code Analyzer scan passed — no violations at or above severity $SEVERITY_THRESHOLD."