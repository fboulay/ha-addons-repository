#!/bin/bash

set -ex

BRANCH=feature/working-version
REPO_NAME=proton-bridge-for-arm

# Clone new code
git clone https://github.com/fboulay/${REPO_NAME}.git proton-bridge
cd proton-bridge
git checkout $BRANCH

# Build
make build-nogui
