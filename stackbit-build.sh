#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5eb52b4e6c6135001a32e75f/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5eb52b4e6c6135001a32e75f 
fi
curl -s -X POST https://api.stackbit.com/project/5eb52b4e6c6135001a32e75f/webhook/build/ssgbuild > /dev/null
hugo

curl -s -X POST https://api.stackbit.com/project/5eb52b4e6c6135001a32e75f/webhook/build/publish > /dev/null
