#!/bin/bash

LATEST_RELEASE_INFO_URL='https://api.github.com/repos/lensapp/lens/releases/latest'

LATEST_TAG=`curl -sL ${LATEST_RELEASE_INFO_URL} | jq -r ".tag_name"`

echo "Latest OpenLens release is ${LATEST_TAG}"

mkdir /tmp/buildtemp

cd /tmp/buildtemp

git clone -b ${LATEST_TAG} https://github.com/lensapp/lens.git lens 2>&1

cd lens

make build

cp dist/*.rpm /opt/distout
