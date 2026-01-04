# Kiwikey Sofle ZMK Config

ZMK firmware for **Sofle keyboard with buttons** (replaces rotary encoders with 2 buttons).

Source: [github.com/kiwikey/zmk-config-kiwikey](https://github.com/kiwikey/zmk-config-kiwikey)

## Hardware Variants

| Variant | Encoder Position | Status |
|---------|------------------|--------|
| **Button** (this config) | 2 buttons | `status = "disabled"` |
| **Knob** (original) | 2 rotary encoders | `status = "okay"` |

## Building Firmware

### Local Build with Docker (Recommended)

```bash
cd kiwikey
./build.sh
```

This will:
1. Clone ZMK repository (first run only)
2. Build firmware for all targets
3. Generate keymap visualization
4. Output `.uf2` files to `build/`

### Build Output

```
build/
├── sofle_dongle-nice_nano_v2-zmk.uf2       # USB dongle (master)
├── sofle_left_peripheral-nice_nano_v2-zmk.uf2  # Left half
├── sofle_right-nice_nano_v2-zmk.uf2        # Right half
└── settings_reset-nice_nano_v2-zmk.uf2     # Reset settings
```

### GitHub Actions

Push to trigger automated build, then download artifacts from Actions tab.

### Manual Docker Commands

```bash
# Build firmware only
docker-compose up --build zmk-builder

# Generate keymap SVG only
docker-compose up keymap-drawer

# Clean build
rm -rf build/ zmk/
```

## Flashing Firmware

### Enter Bootloader Mode

**Double-tap RESET button** on Nice!Nano controller.

### Flash Steps

1. Connect keyboard half via USB-C
2. Double-press RESET → appears as USB drive
3. Drag `.uf2` file to USB drive
4. Auto-reboots after flashing

### Flash Order (Dongle Setup)

1. Flash `sofle_dongle-*.uf2` to dongle
2. Flash `sofle_left_peripheral-*.uf2` to left half
3. Flash `sofle_right-*.uf2` to right half
4. Pair halves to dongle

### Troubleshooting

If pairing issues:
1. Flash `settings_reset-*.uf2` to all devices
2. Re-flash firmware
3. Re-pair

## Project Structure

```
kiwikey/
├── build.sh              # Build script
├── docker-compose.yml    # Docker services
├── Dockerfile            # ZMK build environment
├── build.yaml            # GitHub Actions matrix
├── config/
│   ├── sofle.conf        # ZMK settings
│   ├── sofle.keymap      # Key mappings
│   └── west.yml          # ZMK manifest
├── boards/shields/sofle/
│   ├── sofle.dtsi                  # Base hardware
│   ├── sofle_dongle.overlay        # Dongle config
│   └── sofle_left_peripheral.overlay  # Left peripheral
└── build/                # Output .uf2 files
```

## Switching to Knob Mode

Edit `boards/shields/sofle/sofle.dtsi`:

```dts
left_encoder: encoder_left {
    ...
    status = "okay";  // change from "disabled"
};

right_encoder: encoder_right {
    ...
    status = "okay";  // change from "disabled"
};
```

Then rebuild: `./build.sh`

## Keymap Editor

Online GUI: https://nickcoutsos.github.io/keymap-editor

## Features

- OLED display (128x32 or 128x64)
- ZMK Studio support
- Bluetooth 5.0 with TX power boost
- Deep sleep after 15 minutes
- iPad compatibility mode
- 3 layers: BASE, LOWER, RAISE
