# Keyboard Layer Cheat Sheets

Interactive tmux popup (`prefix + k`) showing the 4 main layers of a Sofle V2 split keyboard running ZMK firmware.

Inspired by [sunaku's Glove80 layout](https://sunaku.github.io/moergo-glove80-keyboard.html#layers) — hundreds of iterations optimizing for inward rolls, bigram efficiency, and ergonomic home row usage.

## Layer Activation

| Key (hold) | Layer | Purpose |
|------------|-------|---------|
| Space | Symbol | Programming symbols |
| Backspace | Cursor | Navigation and editing |
| Tab | Number | Numpad, hex, F-keys |
| Right Tab | Mouse | Mouse emulation |

All layers preserve **home row mods** on the left hand: A=Ctrl, S=Alt, D=Cmd, F=Shift (mirrored on right: J=Shift, K=Cmd, L=Alt, ;=Ctrl). Bilateral design prevents accidental triggers — left mods only fire with right-hand keys and vice versa.

## Symbol Layer (hold Space)

Left hand produces all programming symbols; right hand provides text-editing keys (DEL, BSP, TAB, SPC, RET, ESC).

Design principles from sunaku's layout:
- **Bracket clustering**: `( ) [ ] { }` grouped on the top two rows for easy access during coding
- **Bigram optimization**: common pairs like `()`, `=>`, `->`, `|>`, `!=`, `<=`, `>=` flow as natural inward rolls
- **Arithmetic/logic grouping**: `= _ $ *` on home row, `< | - >` on bottom row for operator sequences
- **Thumb row for extras**: `' " + % :` on the thumb cluster — frequent in strings and formatting
- **Right-hand spacegrams**: space, backspace, and enter on the right hand eliminate layer-switching friction when typing `symbol + space` sequences

## Cursor Layer (hold Backspace)

Left hand mirrors editing keys; right hand has arrow keys and page navigation.

Design principles:
- **Editing keys on left**: RET, SPC, TAB, BSP on the home block — "pinching" model where edit keys (index) and selection keys (thumb) are on the inner wall for simultaneous use
- **Arrow keys on right home row**: LEFT/UP/DOWN/RIGHT on J/K/L/; positions. Deviates from Vim's HJKL to give each finger a single direction
- **Copy/Cut/Paste vertical stack**: natural curling motion toward the palm — copy above paste reflects logical dependency
- **Selection macros on bottom-left**: Ctrl+A (select all), Ctrl+L (select line), Ctrl+W (select word) for context-aware text selection
- **Find/Replace on thumb**: F12, Find, Ctrl+Shift+G (prev), Ctrl+G (next) for search navigation
- **Mirrored CUT/CPY/PST**: available on both halves for one-handed editing

## Number Layer (hold Tab)

Left hand has hex digits and home row mods; right hand is a standard numpad.

Design principles:
- **3x3 numpad on right**: standard 789/456/123 layout for muscle memory consistency, with 0 on thumb
- **Hex A-F on left**: positioned on the top two rows for hex input (0xDEADBEEF)
- **F-keys across top row**: F1-F5 left, F6-F11 right — accessible without leaving the layer
- **Arithmetic operators surrounding numpad**: `-` and `+` on the right edge, `/` and `%` on the bottom for calculations
- **Vim navigation on right edge**: G, K, J keys for prefixed line jumping (e.g., `42G` to jump to line 42)

## Mouse Layer (hold Right Tab)

Both hands provide mouse control with scroll wheels surrounding the movement keys.

Design principles from sunaku's layout:
- **Movement on right home row**: M-LEFT/UP/DOWN/RIGHT on J/I/K/L — centered in home block
- **Scroll wheels surround movement**: scroll up/down/left/right positioned around the movement keys so you can scroll while moving the mouse simultaneously
- **Clicks on natural positions**: LMB (left click) and RMB (right click) flanking the up-arrow, MMB (middle click) on the bottom row
- **FAST key (4x speed)**: hold to activate mouse_fast layer for rapid cursor movement across large screens
- **Left-hand mirror scroll**: S-LEFT/UP/DOWN/RIGHT on A/S/D/F for scrolling while right hand clicks
- **Cut/Copy/Paste on left bottom**: X/C/V positions matching standard shortcuts for clipboard during mouse operations

## Home Row Mods

All home row mods use `balanced` flavor with bilateral key position filtering:

| Finger | Left | Right | Modifier |
|--------|------|-------|----------|
| Pinky | A | ; | Ctrl |
| Ring | S | L | Alt/Opt |
| Middle | D | K | Cmd/GUI |
| Index | F | J | Shift |

- `tapping-term-ms = 280` — hold threshold
- `quick-tap-ms = 175` — tap-then-hold enables auto-repeat
- `require-prior-idle-ms = 75` — fast for Ctrl+Space (tmux prefix)
- Shift on index (F) uses tap-dance: single tap = sticky shift, double tap = caps_word
