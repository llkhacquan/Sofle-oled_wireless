# Use official ZMK Docker image
FROM zmkfirmware/zmk-build-arm:stable

# Set up workspace (ZMK will be mounted from host)
WORKDIR /zmk-workspace

# Create build script for kiwikey Sofle (button version)
RUN cat > /usr/local/bin/build-zmk << 'EOF'
#!/bin/bash
set -e

CONFIG_DIR="$1"
OUTPUT_DIR="$2"
BOARDS_DIR="$3"

if [ -z "$CONFIG_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: build-zmk <config-dir> <output-dir> [boards-dir]"
    exit 1
fi

cd /zmk-workspace

echo "Initializing ZMK workspace..."
if [ ! -f .west/config ]; then
    west init -l app/
    west update
fi

# Add custom boards if provided
EXTRA_MODULES=""
if [ -n "$BOARDS_DIR" ] && [ -d "$BOARDS_DIR" ]; then
    EXTRA_MODULES="-DZMK_EXTRA_MODULES=$BOARDS_DIR"
fi

echo "Building ZMK firmware for Kiwikey Sofle..."

echo "Building sofle_left_peripheral..."
west build -s app -d build/sofle_left -b nice_nano_v2 -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD=sofle_left_peripheral \
    $EXTRA_MODULES

echo "Building sofle_right..."
west build -s app -d build/sofle_right -b nice_nano_v2 -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD=sofle_right \
    $EXTRA_MODULES

echo "Building sofle_dongle..."
west build -s app -d build/sofle_dongle -b nice_nano_v2 -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD="sofle_dongle dongle_display" \
    $EXTRA_MODULES

echo "Building settings_reset..."
west build -s app -d build/settings_reset -b nice_nano_v2 -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD=settings_reset

# Copy .uf2 files to output directory
mkdir -p "$OUTPUT_DIR"
cp build/sofle_left/zephyr/zmk.uf2 "$OUTPUT_DIR/sofle_left_peripheral-nice_nano_v2-zmk.uf2"
cp build/sofle_right/zephyr/zmk.uf2 "$OUTPUT_DIR/sofle_right-nice_nano_v2-zmk.uf2"
cp build/sofle_dongle/zephyr/zmk.uf2 "$OUTPUT_DIR/sofle_dongle-nice_nano_v2-zmk.uf2"
cp build/settings_reset/zephyr/zmk.uf2 "$OUTPUT_DIR/settings_reset-nice_nano_v2-zmk.uf2"

echo "Firmware built successfully!"
ls -la "$OUTPUT_DIR"/*.uf2
EOF

RUN chmod +x /usr/local/bin/build-zmk

WORKDIR /workspace

CMD ["build-zmk", "/workspace/config", "/workspace/build", "/workspace/boards"]
