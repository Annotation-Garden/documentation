#!/bin/bash
# Build script for Cloudflare Pages

set -e

echo "Initializing submodules..."
git submodule update --init --recursive

echo "Updating submodules to latest from main branch..."
git submodule update --remote --merge

echo "Building documentation..."
mkdocs build

echo "Build complete!"
