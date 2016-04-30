#!/bin/bash

set -e

swift build --fetch # clones all dependencies
rm -rf Packages/*/Tests
swift build -Xcc -fblocks
swift test
