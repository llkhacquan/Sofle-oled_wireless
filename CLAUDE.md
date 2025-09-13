# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a ZMK firmware configuration repository for the Sofle V2 keyboard with wireless Nice!Nano controllers and OLED displays. The repository is set up as a ZMK user config that leverages GitHub Actions for firmware building and keymap visualization.

## Key Files and Structure

- `config/sofle.keymap` - Main keymap configuration with 4 layers (BASE, LOWER, RAISE, ADJUST)
- `config/sofle.conf` - ZMK configuration settings (OLED display, encoders, RGB underglow)
- `build.yaml` - GitHub Actions matrix configuration for firmware builds
- `sofle.yaml` - Keymap layout configuration for keymap-drawer visualization
- `keymap-drawer/` - Generated keymap visualizations (SVG and YAML files)
- `.github/workflows/` - Automated workflows for building and visualization

## Development Workflow

### Keymap Modification
1. **Online Editor (Recommended)**: Use https://nickcoutsos.github.io/keymap-editor
   - Repository is pre-configured to work with this editor
   - Make changes and commit directly through the web interface

2. **Manual Editing**: Modify `config/sofle.keymap` directly
   - Edit layer definitions using ZMK keycode syntax
   - Follow existing indentation and structure patterns
   - The file defines 4 layers with conditional layer activation (ADJUST layer activated when both LOWER and RAISE are pressed)

### Firmware Building
- Firmware builds are handled automatically via GitHub Actions
- Triggered on: push, pull request, or manual workflow dispatch
- Uses `zmkfirmware/zmk/.github/workflows/build-user-config.yml@main`
- Builds for Nice!Nano v2 with left/right splits and settings reset
- Download `.uf2` files from GitHub Actions artifacts after successful builds

### Keymap Visualization
- Automatic keymap drawing via keymap-drawer workflow
- Triggered on changes to `config/*.keymap` files or keymap configuration
- Generates SVG visualization in `keymap-drawer/` directory
- Uses `caksoylar/keymap-drawer` action

## Configuration Options

### Hardware Features (sofle.conf)
- OLED Display: `CONFIG_ZMK_DISPLAY=y` (enabled)
- Rotary Encoders: `CONFIG_EC11=y` (enabled)
- RGB Underglow: Commented out (disabled by default)
- External power control for RGB: Commented out

### Keymap Structure
- **BASE Layer (0)**: Default QWERTY layout with modifier keys
- **LOWER Layer (1)**: Numbers, function keys, symbols
- **RAISE Layer (2)**: Navigation, Bluetooth controls, system functions
- **ADJUST Layer (3)**: RGB controls, Bluetooth management (activated when LOWER + RAISE)

## Flashing Process
1. Connect keyboard via USB-C cable
2. Double-press BOOT button to enter bootloader mode
3. Drag and drop appropriate `.uf2` file to the USB drive
4. Files needed: `sofle_left-nice_nano_v2-zmk.uf2`, `sofle_right-nice_nano_v2-zmk.uf2`
5. Optional: `settings_reset-nice_nano_v2-zmk.uf2` for clearing settings

## West Configuration
- Uses ZMK firmware from `zmkfirmware/zmk` repository
- Configuration follows standard ZMK user config structure
- Self-path set to `config` directory for ZMK build system