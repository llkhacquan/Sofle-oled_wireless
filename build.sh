#!/bin/bash

set -e

echo "🔨 Building Sofle firmware with Docker..."

# Create build directory if it doesn't exist
mkdir -p build

# Clone ZMK locally if not already present
if [ ! -d "zmk" ]; then
    echo "📦 Cloning ZMK repository (one-time setup)..."
    git clone --depth 1 --single-branch https://github.com/zmkfirmware/zmk.git zmk
    echo "✅ ZMK cloned successfully!"
fi

# Build the Docker image and run the build
docker-compose up --build zmk-builder

echo ""
echo "🎨 Generating keymap visualization..."

# Generate SVG keymap
docker-compose up keymap-drawer

echo ""
echo "🎉 Build complete!"
echo ""
echo "📱 Firmware files created:"
if [ -d "build" ]; then
    ls -la build/*.uf2 2>/dev/null || echo "  No .uf2 files found in build directory"
fi

echo ""
echo "🎨 Keymap visualization:"
if [ -f "keymap-drawer/sofle.svg" ]; then
    echo "  ✅ keymap-drawer/sofle.svg"
else
    echo "  ❌ SVG generation failed"
fi

echo ""
echo "💡 To flash firmware:"
echo "  1. Connect keyboard via USB-C"
echo "  2. Double-press BOOT button to enter bootloader"
echo "  3. Copy the appropriate .uf2 file to the USB drive"
echo ""
echo "Files needed:"
echo "  - build/sofle_left-nice_nano_v2-zmk.uf2 (left half)"
echo "  - build/sofle_right-nice_nano_v2-zmk.uf2 (right half)"
echo "  - build/settings_reset-nice_nano_v2-zmk.uf2 (optional - clears settings)"