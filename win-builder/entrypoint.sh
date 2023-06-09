#!/bin/bash

LATEST_RELEASE_INFO_URL='https://api.github.com/repos/lensapp/lens/releases/latest'

LATEST_TAG=`curl -sL ${LATEST_RELEASE_INFO_URL} | jq -r ".tag_name"`

echo "Latest OpenLens release is ${LATEST_TAG}"

mkdir /tmp/buildtemp

cd /tmp/buildtemp

git clone -b ${LATEST_TAG} https://github.com/lensapp/lens.git lens 2>&1

cd lens

yarn install --check-files --frozen-lockfile --network-timeout=100000

sed -i 's/electron-builder --publish onTag",/electron-builder --publish onTag --win",/' packages/open-lens/package.json
#sed -i 's/forPlatform === "windows"/forPlatform === "windows" || true/' packages/ensure-binaries/src/index.ts
#sed -i 's/normalizedPlatform !== "windows"/false/' packages/ensure-binaries/src/index.ts
##sed -i 's/\$\{args\.platform\}/windows/g' packages/ensure-binaries/src/index.ts
sed -i 's/switch (process.platform)/switch ("win32")/' packages/ensure-binaries/src/index.ts

yarn lerna run build:app

ls -la packages/open-lens/dist
cp packages/open-lens/dist/*.exe /opt/distout
