#!/usr/bin/env bash
# scripts/generate_keystore.sh
#
# One-time helper: generates a release keystore and encodes it for CI.
#
# Usage:
#   chmod +x scripts/generate_keystore.sh
#   ./scripts/generate_keystore.sh
#
# Output:
#   android/app/release.jks          ← keep SECRET, never commit
#   android/key.properties           ← keep SECRET, never commit
#
# After running:
#   1. Copy the printed base64 blob → GitHub secret  KEYSTORE_BASE64
#   2. Add the other three values   → GitHub secrets KEY_ALIAS / KEY_PASSWORD / STORE_PASSWORD

set -euo pipefail

KEYSTORE_PATH="android/app/release.jks"
KEY_PROPERTIES="android/key.properties"

# ── Prompt for values ─────────────────────────────────────────────────────────
read -rp "Key alias (e.g. widget_app_key): " KEY_ALIAS
read -rsp "Key password: " KEY_PASSWORD; echo
read -rsp "Store password: " STORE_PASSWORD; echo
read -rp  "Your name (for the certificate): " DNAME

# ── Generate keystore ─────────────────────────────────────────────────────────
keytool -genkeypair \
  -alias "$KEY_ALIAS" \
  -keyalg RSA \
  -keysize 4096 \
  -validity 10000 \
  -keystore "$KEYSTORE_PATH" \
  -storepass "$STORE_PASSWORD" \
  -keypass "$KEY_PASSWORD" \
  -dname "CN=$DNAME, OU=Android, O=widget_app, L=Unknown, ST=Unknown, C=US"

echo ""
echo "✓ Keystore written to $KEYSTORE_PATH"

# ── Write key.properties (used by build.gradle.kts locally) ──────────────────
cat > "$KEY_PROPERTIES" <<EOF
storePassword=$STORE_PASSWORD
keyPassword=$KEY_PASSWORD
keyAlias=$KEY_ALIAS
storeFile=release.jks
EOF

echo "✓ key.properties written to $KEY_PROPERTIES"
echo ""

# ── Print base64 for CI secret ────────────────────────────────────────────────
echo "══════════════════════════════════════════════════════════════════"
echo "Copy the block below into GitHub secret  KEYSTORE_BASE64"
echo "(Settings → Secrets and variables → Actions → New repository secret)"
echo "══════════════════════════════════════════════════════════════════"
echo ""
base64 -w 0 "$KEYSTORE_PATH"
echo ""
echo ""
echo "Also add these repository secrets:"
echo "  KEY_ALIAS       = $KEY_ALIAS"
echo "  KEY_PASSWORD    = (the password you just entered)"
echo "  STORE_PASSWORD  = (the store password you just entered)"
echo ""
echo "⚠  The .jks file and key.properties are in .gitignore — do NOT commit them."
