#!/bin/bash
# Build script for Cloudflare Pages
# Clones source repositories for mkdocstrings API documentation

set -e

echo "Cloning source repositories for API documentation..."
git clone --depth 1 https://github.com/Annotation-Garden/hedit.git ../hedit
git clone --depth 1 https://github.com/Annotation-Garden/image-annotation.git ../image-annotation

echo "Installing dependencies..."
pip install .

echo "Building documentation..."
mkdocs build

echo "Build complete!"
