curl -sSL https://api.github.com/repos/dhmeBrnawe/denokv-x64-mac-build/releases/latest -o release.json

# Check release.json exists and is not empty
if [ ! -s release.json ]; then
echo "Failed to download release.json"
exit 1
fi

# Extract the download URL of the first asset
download_url=$(jq -r '.assets[0].browser_download_url // empty' release.json)
if [[ -z "$download_url" ]]; then
echo "Failed to parse download_url from release.json"
cat release.json
exit 1
fi
mkdir -p ./node_modules/@deno/kv-darwin-x64
curl -L "$download_url" -o ./node_modules/@deno/kv-darwin-x64/deno-kv-napi.darwin-x64.node
