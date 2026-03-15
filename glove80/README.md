# Glove80 Keymap Configuration

MoErgo Glove80 keymap using [sunaku's keymap](https://sunaku.github.io/glove80-keymap.html) framework, with custom HRM tuning and per-finger timing.

## Files

| File | Purpose |
|------|---------|
| `quannk.json` | Full Layout Editor export (source of truth for layers) |
| `config/overrides.h` | **Edit this** — HRM tuning, behavior toggles |
| `config/snippet.h` | sunaku's keymap snippet (don't edit directly) |
| `config/layers.json` | Layer key assignments from Layout Editor |
| `config/metadata.json` | Layout Editor metadata |
| `config/devicetree.dtsi` | Custom devicetree overlays |
| `glove80-split.py` | Split `quannk.json` → `config/` files for version control |
| `glove80-merge.py` | Merge `config/` files → `quannk.json` for upload |

## Workflow

### Editing HRM / Behavior Config
```bash
# 1. Edit overrides
vim config/overrides.h

# 2. Merge back into JSON
python3 glove80-merge.py

# 3. Upload quannk.json to Glove80 Layout Editor
# 4. Build firmware in the web app and download
```

### After Exporting from Layout Editor
```bash
# Split the exported JSON into editable files
python3 glove80-split.py quannk.json config/

# Review changes, commit
```

### Editing Layers
Use the [Glove80 Layout Editor](https://my.glove80.com) web app to modify layers. Export → replace `quannk.json` → run `glove80-split.py` to update version-controlled files.

## HRM Configuration (overrides.h)

Balanced flavor with uniform timing. Keep in sync with Sofle keyboards (`knob/` and `kiwikey/`).

| Parameter | Value |
|-----------|-------|
| Holding time (tapping-term) | 280ms |
| Repeat decay (quick-tap) | 175ms |
| Streak decay (prior-idle) | 75ms |
