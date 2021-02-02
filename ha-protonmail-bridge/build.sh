#!/bin/bash

set -ex

VERSION=1.4.5

# Clone new code
git clone https://github.com/ProtonMail/proton-bridge.git
cd proton-bridge
git checkout v$VERSION

# Build
make build-nogui
