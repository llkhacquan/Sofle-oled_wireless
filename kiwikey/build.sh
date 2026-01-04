#!/bin/bash

set -e

echo "Building Kiwikey Sofle firmware with Docker..."

mkdir -p build
mkdir -p keymap-drawer

# Clone ZMK if not present
if [ ! -d "zmk" ]; then
    echo "Cloning ZMK repository (one-time setup)..."
    git clone --depth 1 --single-branch https://github.com/zmkfirmware/zmk.git zmk
fi

# Build firmware
docker-compose up --build zmk-builder

echo ""
echo "Generating keymap visualization..."
docker-compose up keymap-drawer

echo ""
echo "Build complete!"
echo ""
echo "Firmware files:"
ls -la build/*.uf2 2>/dev/null || echo "  No .uf2 files found"

echo ""
echo "Keymap visualization:"
if [ -f "keymap-drawer/sofle.svg" ]; then
    cp keymap-drawer/sofle.svg sofle.svg
    echo "  sofle.svg"
fi

echo ""
echo "Flashing instructions:"
echo "  1. Connect keyboard via USB-C"
echo "  2. Double-press RESET button to enter bootloader"
echo "  3. Drag .uf2 file to USB drive"
echo ""
echo "Firmware files:"
echo "  - sofle_dongle-*.uf2      (USB dongle)"
echo "  - sofle_left_peripheral-*.uf2  (left half)"
echo "  - sofle_right-*.uf2       (right half)"
echo "  - settings_reset-*.uf2    (clear settings)"
