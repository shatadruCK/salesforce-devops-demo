#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
# quick-deploy.sh
# Promotes a previously validated check-only deployment to a real deploy
# WITHOUT re-running tests. Only works if validation passed within 10 days.
#
# Required env vars:
#   TARGET_ORG_ALIAS   — sf org alias for the target org
#   DEPLOY_JOB_ID      — Job ID saved from validate.sh
# ─────────────────────────────────────────────────────────────────────

set -euo pipefail

TARGET_ORG_ALIAS="${ORG_ALIAS}"
DEPLOY_JOB_ID="$FINAL_DEPLOY_ID:?❌ FINAL_DEPLOY_ID is required — run validate.sh first"
RESULT_FILE="quick-deploy-result.json"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Quick Deploy (no test re-run)"
echo " Target org  : $TARGET_ORG_ALIAS"
echo " Job ID      : $DEPLOY_JOB_ID"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ── Promote the validated deployment ─────────────────────────────
sf project deploy quick \
  --job-id     "$DEPLOY_JOB_ID" \
  --target-org "$TARGET_ORG_ALIAS" \
  --wait       60 \
  --json \
  | tee "$RESULT_FILE"

DEPLOY_EXIT_CODE=${PIPESTATUS[0]}

# ── Show result ───────────────────────────────────────────────────
if [ "$DEPLOY_EXIT_CODE" != "0" ]; then
  echo ""
  echo "❌  Quick deploy failed."
  echo "    Check quick-deploy-result.json for details."
  exit "$DEPLOY_EXIT_CODE"
fi

echo ""
echo "✅  Quick deploy succeeded — code is live in $TARGET_ORG_ALIAS."