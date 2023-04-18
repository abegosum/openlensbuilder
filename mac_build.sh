#!/bin/bash

LATEST_RELEASE_INFO_URL='https://api.github.com/repos/lensapp/lens/releases/latest'

LATEST_TAG=`curl -sL ${LATEST_RELEASE_INFO_URL} | jq -r ".tag_name"`

echo "Latest OpenLens release is ${LATEST_TAG}"

if [ -d 'buildtemp' ] ; then
  rm -rf buildtemp
fi

mkdir buildtemp

cd buildtemp

git clone -b ${LATEST_TAG} https://github.com/lensapp/lens.git lens 2>&1

cd lens

yarn install --check-files --frozen-lockfile --network-timeout=100000

sed -i 's/electron-builder --publish onTag",/electron-builder --publish onTag --mac dmg",/' packages/open-lens/package.json

yarn lerna run build:app

cp packages/open-lens/dist/*.dmg ../../distout
