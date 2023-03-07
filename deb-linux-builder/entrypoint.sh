#!/bin/bash

LATEST_RELEASE_INFO_URL='https://api.github.com/repos/lensapp/lens/releases/latest'

LATEST_TAG=`curl -sL ${LATEST_RELEASE_INFO_URL} | jq -r ".tag_name"`

echo "Latest OpenLens release is ${LATEST_TAG}"

mkdir /tmp/buildtemp

cd /tmp/buildtemp

git clone -b ${LATEST_TAG} https://github.com/lensapp/lens.git lens 2>&1

cd lens

yarn install --check-files --frozen-lockfile --network-timeout=100000

sed -i 's/electron-builder --publish onTag",/electron-builder --publish onTag --linux deb --linux AppImage",/' packages/open-lens/package.json

yarn lerna run build:app

cp packages/open-lens/dist/*.AppImage /opt/distout
cp packages/open-lens/dist/*.deb /opt/distout
