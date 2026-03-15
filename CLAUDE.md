# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Keyboard firmware configurations for 3 keyboards sharing the same ergonomic keymap layout (home row mods, tap-then-hold auto-repeat, 6 specialized layers). All keyboards target macOS with identical modifier assignments.

**Layout consistency:** All 3 keyboards share the same keymap layout and HRM tuning. Keep them in sync when making changes.

### Keyboards

| Directory | Hardware | Firmware | Build Method |
|-----------|----------|----------|--------------|
| `knob/` | Sofle V2 + Nice!Nano v2 | ZMK | Docker (`knob/build.sh`) or GitHub Actions |
| `kiwikey/` | Sofle V2 + Nice!Nano v2 | ZMK | Docker (`kiwikey/build.sh`) or GitHub Actions |
| `glove80/` | MoErgo Glove80 | ZMK (sunaku's keymap) | Glove80 Layout Editor web app |

- **knob** vs **kiwikey**: Same keymap, only difference is knob has rotary encoder support
- **glove80**: Uses sunaku's keymap framework; config split into editable files via `glove80-split.py`

## Key Files and Structure

### Sofle (knob/ and kiwikey/)
- `config/sofle.keymap` - Main keymap configuration with 6 layers
- `config/sofle.conf` - ZMK configuration (OLED, encoders, power management)
- `build.sh` - Local Docker-based build script
- `build.yaml` - GitHub Actions matrix configuration
- `sofle.yaml` - Keymap layout for keymap-drawer visualization
- `keymap-drawer/` - Generated keymap visualizations (SVG and YAML)

### Glove80 (glove80/)
- `quannk.json` - Full Layout Editor export (source of truth)
- `config/overrides.h` - User HRM/behavior overrides (edit this!)
- `config/snippet.h` - sunaku's keymap snippet (don't edit)
- `config/layers.json` - Layer definitions from Layout Editor
- `glove80-split.py` / `glove80-merge.py` - Split/merge JSON for version control

### Root
- `Makefile` - Build both Sofle keyboards: `make build`

## Building Firmware

### Sofle (knob/kiwikey)
```bash
make build          # Build both keyboards
make build-knob     # Build knob only
make build-kiwikey  # Build kiwikey only
make clean          # Remove build artifacts
```

Each `build.sh` clones ZMK (one-time), builds left/right/reset `.uf2` files via Docker, and generates keymap SVG.

**Output:** `{keyboard}/build/*.uf2` and `{keyboard}/sofle.svg`

**Cloud build:** GitHub Actions triggers on push/PR, download `.uf2` from artifacts.

### Glove80
1. Edit `glove80/config/overrides.h` (HRM tuning, behavior settings)
2. Run `glove80/glove80-merge.py` to merge back into `quannk.json`
3. Upload `quannk.json` to Glove80 Layout Editor web app
4. Build and download firmware from the web app

## Keymap Architecture (Shared Across All 3 Keyboards)

### Layer Structure (6 Layers)
- **BASE (0)**: QWERTY with home row mods (macOS: A=Ctrl, S=Alt, D=Cmd, F=Shift / mirror on right)
- **LOWER (1)**: Symbols, programming operators (hold Space)
- **RAISE (2)**: Cursor navigation, text editing (hold Backspace)
- **NUMBER (3)**: Numpad, F1-F12, hex digits (hold Tab)
- **ADJUST (4)**: Bluetooth, RGB controls (LOWER + RAISE)
- **MOUSE (5)**: Mouse movement and scrolling

### Home Row Mods (Per-Finger Tuning)

Balanced flavor with uniform timing across all fingers.

| Parameter | Value | ZMK property |
|-----------|-------|--------------|
| Tapping term | 280ms | `tapping-term-ms` / `HOLDING_TIME` |
| Quick-tap (repeat decay) | 175ms | `quick-tap-ms` / `HOMEY_REPEAT_DECAY` |
| Prior idle (streak decay) | 75ms | `require-prior-idle-ms` / `STREAK_DECAY` |

**Sync rule:** When changing HRM timing, update all 3 keyboards to match. Sofle source of truth is `kiwikey/config/sofle.keymap`, Glove80 is `glove80/config/overrides.h`.

### Other Behaviors
- **Layer-tap auto-repeat**: Thumb keys (Space/Tab/Bksp) — tap-then-hold = auto-repeat, direct hold = layer
- **Bootloader combos** (Sofle only): 3-key combo (3+4+5 left, 6+7+8 right), 1000ms timeout
- **Conditional layers**: ADJUST = LOWER + RAISE held simultaneously

## Keymap Modification

### Sofle (knob/kiwikey)
- **GUI editor**: https://nickcoutsos.github.io/keymap-editor (commit directly)
- **Manual**: Edit `config/sofle.keymap` → run `./build.sh` → check SVG → flash `.uf2`

### Glove80
- Edit `glove80/config/overrides.h` → merge → upload to Layout Editor

### Flashing Sofle
1. Enter bootloader: combo keys 3+4+5 (left) or 6+7+8 (right)
2. Drag `.uf2` to USB drive. Flash right half first, then left.
3. **Troubleshooting:** Flash `settings_reset` firmware first if issues occur.

## Hardware Configuration

### Sofle (config/sofle.conf)
- OLED display, rotary encoders (knob only), BT 5.0 (Nice!Nano v2)
- RGB underglow available but disabled for battery life
- Mouse keys with 4 speed modes (FINE/SLOW/FAST/WARP)

### Glove80
- Built-in BT, RGB, per-key LEDs
- Configuration managed through Layout Editor web app