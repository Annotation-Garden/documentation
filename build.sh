#!/bin/bash
# Build script for Cloudflare Pages

set -e

echo "Initializing submodules..."
git submodule update --init --recursive

echo "Building documentation..."
mkdocs build

echo "Build complete!"
