# scripts/generate_keystore.ps1
#
# Windows PowerShell equivalent of generate_keystore.sh
# Run from the project root:  .\scripts\generate_keystore.ps1

$ErrorActionPreference = "Stop"

$KEYTOOL = "C:\Program Files\Java\jdk-20\bin\keytool.exe"
$KEYSTORE_PATH = "android\app\release.jks"
$KEY_PROPS = "android\key.properties"

Write-Host ""
Write-Host "=== Widget App Release Keystore Generator ===" -ForegroundColor Cyan
Write-Host ""

$KEY_ALIAS = Read-Host "Key alias       (e.g. widget_app_key)"
$KEY_PASSWORD = Read-Host "Key password    (min 6 chars)" -AsSecureString
$STORE_PASSWORD = Read-Host "Store password  (min 6 chars)" -AsSecureString
$DNAME = Read-Host "Your name       (for the certificate)"

# Convert SecureString → plain for keytool
$keyPass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($KEY_PASSWORD))
$storePass = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($STORE_PASSWORD))

# ── Generate keystore ─────────────────────────────────────────────────────────
Write-Host ""
Write-Host "Generating keystore..." -ForegroundColor Yellow

& $KEYTOOL -genkeypair `
    -alias       $KEY_ALIAS `
    -keyalg      RSA `
    -keysize     4096 `
    -validity    10000 `
    -keystore    $KEYSTORE_PATH `
    -storepass   $storePass `
    -keypass     $keyPass `
    -dname       "CN=$DNAME, OU=Android, O=widget_app, L=Unknown, ST=Unknown, C=US" `
    -noprompt

if (-not (Test-Path $KEYSTORE_PATH)) {
    Write-Host "ERROR: Keystore was not created. Check your inputs." -ForegroundColor Red
    exit 1
}

Write-Host "Keystore written to $KEYSTORE_PATH" -ForegroundColor Green

# ── Write key.properties ──────────────────────────────────────────────────────
@"
storePassword=$storePass
keyPassword=$keyPass
keyAlias=$KEY_ALIAS
storeFile=release.jks
"@ | Set-Content -Path $KEY_PROPS -Encoding UTF8

Write-Host "key.properties written to $KEY_PROPS" -ForegroundColor Green

# ── Base64 encode for CI secret ───────────────────────────────────────────────
$bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $KEYSTORE_PATH))
$base64 = [System.Convert]::ToBase64String($bytes)

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "Add these 4 secrets to GitHub:" -ForegroundColor Cyan
Write-Host "(Settings -> Secrets and variables -> Actions -> New repository secret)" -ForegroundColor Gray
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Secret name   : KEYSTORE_BASE64" -ForegroundColor White
Write-Host "Secret value  :" -ForegroundColor White
Write-Host $base64 -ForegroundColor Yellow
Write-Host ""
Write-Host "Secret name   : KEY_ALIAS" -ForegroundColor White
Write-Host "Secret value  : $KEY_ALIAS" -ForegroundColor Yellow
Write-Host ""
Write-Host "Secret name   : KEY_PASSWORD" -ForegroundColor White
Write-Host "Secret value  : (the key password you just typed)" -ForegroundColor Yellow
Write-Host ""
Write-Host "Secret name   : STORE_PASSWORD" -ForegroundColor White
Write-Host "Secret value  : (the store password you just typed)" -ForegroundColor Yellow
Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "WARNING: release.jks and key.properties are in .gitignore." -ForegroundColor Red
Write-Host "NEVER commit them. Back up release.jks somewhere safe." -ForegroundColor Red
Write-Host "================================================================" -ForegroundColor Cyan
