# Use official ZMK Docker image
FROM zmkfirmware/zmk-build-arm:stable

# Install Ruby for template processing (similar to glove80)
RUN apt-get update && apt-get install -y ruby && rm -rf /var/lib/apt/lists/*

# Set up workspace (ZMK will be mounted from host)
WORKDIR /zmk-workspace

# Create build script
RUN cat > /usr/local/bin/build-zmk << 'EOF'
#!/bin/bash
set -e

CONFIG_DIR="$1"
OUTPUT_DIR="$2"

if [ -z "$CONFIG_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: build-zmk <config-dir> <output-dir>"
    echo "Example: build-zmk /workspace/config /workspace/build"
    exit 1
fi

cd /zmk-workspace

echo "Initializing ZMK workspace..."
# Initialize west workspace if not already done
if [ ! -f .west/config ]; then
    west init -l app/
    west update
fi

echo "Building ZMK firmware..."

# Build configurations from build.yaml
echo "Building sofle_left..."
west build -s app -d build/sofle_left -b nice_nano -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD=sofle_left

echo "Building sofle_right..."
west build -s app -d build/sofle_right -b nice_nano -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD=sofle_right

echo "Building settings_reset..."
west build -s app -d build/settings_reset -b nice_nano -- \
    -DZMK_CONFIG="$CONFIG_DIR" \
    -DSHIELD=settings_reset

# Copy .uf2 files to output directory
mkdir -p "$OUTPUT_DIR"
cp build/sofle_left/zephyr/zmk.uf2 "$OUTPUT_DIR/sofle_left-nice_nano_v2-zmk.uf2"
cp build/sofle_right/zephyr/zmk.uf2 "$OUTPUT_DIR/sofle_right-nice_nano_v2-zmk.uf2"
cp build/settings_reset/zephyr/zmk.uf2 "$OUTPUT_DIR/settings_reset-nice_nano_v2-zmk.uf2"

echo "✅ Firmware built successfully!"
echo "Files created in $OUTPUT_DIR:"
ls -la "$OUTPUT_DIR"/*.uf2
EOF

# Make build script executable
RUN chmod +x /usr/local/bin/build-zmk

# Set working directory for mounted volume
WORKDIR /workspace

# Default command
CMD ["build-zmk", "/workspace/config", "/workspace/build"]