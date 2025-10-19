# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a ZMK firmware configuration repository for the Sofle V2 keyboard with wireless Nice!Nano controllers and OLED displays. The keymap is inspired by the glove80 layout, featuring advanced ergonomic capabilities including home row mods, tap-then-hold auto-repeat, and 6 specialized layers. The repository supports both GitHub Actions (cloud builds) and Docker-based local builds.

## Key Files and Structure

- `config/sofle.keymap` - Main keymap configuration with 6 layers (BASE, LOWER, RAISE, NUMBER, ADJUST, MOUSE)
- `config/sofle.conf` - ZMK configuration settings (OLED display, encoders, RGB underglow)
- `build.yaml` - GitHub Actions matrix configuration for firmware builds
- `build.sh` - Local Docker-based build script (builds firmware + generates keymap visualization)
- `docker-compose.yml` - Docker services for ZMK building and keymap visualization
- `Dockerfile` - ZMK build environment with west tooling
- `sofle.yaml` - Keymap layout configuration for keymap-drawer visualization
- `keymap-drawer/` - Generated keymap visualizations (SVG and YAML files)
- `.github/workflows/build.yml` - Automated CI/CD workflow for firmware building

## Building Firmware

### Local Build (Recommended for Development)
```bash
./build.sh
```
This single command:
1. Clones ZMK repository if not present (one-time setup)
2. Builds firmware for left half, right half, and settings reset using Docker
3. Generates keymap visualization SVG (single-column layout)
4. Outputs `.uf2` files to `build/` directory
5. Copies generated SVG to root for easy viewing

**Output files:**
- `build/sofle_left-nice_nano_v2-zmk.uf2`
- `build/sofle_right-nice_nano_v2-zmk.uf2`
- `build/settings_reset-nice_nano_v2-zmk.uf2`
- `sofle.svg` (keymap visualization, copied from keymap-drawer/)

### Cloud Build (GitHub Actions)
- Triggered automatically on: push, pull request, or manual workflow dispatch
- Uses `zmkfirmware/zmk/.github/workflows/build-user-config.yml@main`
- Download `.uf2` files from GitHub Actions artifacts after successful builds
- Separate keymap visualization workflow also runs on keymap changes

### Manual Docker Commands
```bash
# Build firmware only
docker-compose up zmk-builder

# Generate keymap visualization only
docker-compose up keymap-drawer

# Clean build artifacts
rm -rf build/ zmk/
```

## Keymap Architecture

### Layer Structure (6 Layers)
- **BASE (0)**: QWERTY layout with home row mods (macOS optimized)
  - Left hand: A(Ctrl), S(Alt), D(Cmd), F(Shift)
  - Right hand: J(Shift), K(Cmd), L(Alt), ;(Ctrl)
- **LOWER (1)**: Symbols, programming operators, navigation (hold Space)
- **RAISE (2)**: Cursor navigation, text editing commands (hold Backspace)
- **NUMBER (3)**: Numpad layout, function keys F1-F12, hex digits (hold Tab)
- **ADJUST (4)**: Bluetooth management, RGB controls (activated when LOWER + RAISE)
- **MOUSE (5)**: Mouse movement and scrolling with configurable speeds

### Advanced Behaviors

**Home Row Mods (config/sofle.keymap:90-99)**
- Tapping term: 200ms
- Quick-tap: 300ms (tap-then-hold auto-repeat)
- Prior-idle: 100ms (prevents accidental activation)
- Retro-tap enabled (forgiveness on hold-release)

**Layer-Tap with Auto-Repeat (config/sofle.keymap:77-86)**
- Thumb keys (Space, Tab, Backspace) support tap-then-hold auto-repeat
- Single tap → Normal key behavior
- Direct hold → Layer activation
- Tap-then-hold → Fast auto-repeat bypassing layer (glove80-style)

**Bootloader Combos (config/sofle.keymap:56-71)**
- Left half: Press keys at positions 2+5 within 500ms
- Right half: Press keys at positions 9+6 within 500ms
- Enables software bootloader access without physical BOOT button

### Conditional Layers
- ADJUST layer automatically activates when both LOWER and RAISE are held simultaneously
- Defined at config/sofle.keymap:44-51

## Keymap Modification

### Online Editor (Easy GUI Method)
Use https://nickcoutsos.github.io/keymap-editor
- Repository is pre-configured to work with this editor
- Make changes and commit directly through the web interface

### Manual Editing
Edit `config/sofle.keymap` directly:
- Layer definitions use ZMK keycode syntax
- Custom behaviors defined in `behaviors` block
- Combos defined in `combos` block
- Mouse configuration constants at top of file (lines 24-39)

### After Editing
1. Run `./build.sh` to build and visualize
2. Check generated `sofle.svg` to verify changes
3. Flash `.uf2` files to keyboard

## Flashing Process

### Software Bootloader Method (No Physical Button)
1. **Left half**: Press combo keys 2+5 within 500ms → enters bootloader
2. **Right half**: Press combo keys 9+6 within 500ms → enters bootloader
3. Drag appropriate `.uf2` file to USB drive
4. Firmware flashes automatically

### Physical Button Method (Fallback)
1. Connect keyboard via USB-C cable
2. Double-press "BOOT" button quickly
3. Drag appropriate `.uf2` file to USB drive

### Recommended Flashing Order
1. Turn off both keyboard halves
2. Flash right half first
3. Flash left half second
4. Turn on right half → should show connection status on OLED
5. Test both halves

**Troubleshooting:** Flash `settings_reset-nice_nano_v2-zmk.uf2` first if experiencing issues

## Configuration Details

### Hardware Features (config/sofle.conf)
- OLED Display: `CONFIG_ZMK_DISPLAY=y` (enabled)
- Rotary Encoders: `CONFIG_EC11=y` (enabled, 5-way on right side)
- RGB Underglow: Available but disabled by default for battery life
- Nice!Nano v2: Bluetooth 5.0 wireless controllers

### Mouse Configuration (config/sofle.keymap:24-39)
Adapted from glove80 with configurable speed scaling:
- Motion acceleration exponent, time to max speed, maximum speed
- Scroll acceleration and speed settings
- Four speed modes: FINE (1/16), SLOW (1/4), FAST (4x), WARP (12x)

### Timing Parameters
- **Home row mods**: 200ms tap term, 300ms quick-tap, 100ms prior-idle
- **Layer-tap**: 200ms tap term, 200ms quick-tap
- **Bootloader combos**: 500ms timeout

## West Configuration
- Uses ZMK firmware from `zmkfirmware/zmk` repository
- Configuration follows standard ZMK user config structure
- Local builds cache ZMK in `zmk/` directory (auto-cloned by build.sh)
- West workspace initialized automatically by Docker build script