#!/usr/bin/env python3
"""Split a Glove80 Layout Editor JSON export into editable files.

Usage: python3 glove80-split.py [input.json] [output_dir]
  Defaults: quannk.json -> config/

After splitting, patches snippet.h to add bilateral thumb key support
(thumb keys added to both LEFT_HAND_KEYS and RIGHT_HAND_KEYS).
"""
import json
import os
import re
import sys

input_file = sys.argv[1] if len(sys.argv) > 1 else "quannk.json"
output_dir = sys.argv[2] if len(sys.argv) > 2 else "config"

with open(input_file) as f:
    data = json.load(f)

os.makedirs(output_dir, exist_ok=True)

# 1. Extract custom_defined_behaviors (the main config you edit)
cdb = data.get("custom_defined_behaviors", "")
# Split user overrides from the main snippet
separator = "//////////////////////////////////////////////////////////////////////////////"
parts = cdb.split(separator, 1)
if len(parts) == 2:
    with open(os.path.join(output_dir, "overrides.h"), "w") as f:
        f.write(parts[0].rstrip() + "\n")
    with open(os.path.join(output_dir, "snippet.h"), "w") as f:
        f.write(separator + parts[1])
    print(f"  {output_dir}/overrides.h  - YOUR custom overrides (edit this!)")
    print(f"  {output_dir}/snippet.h    - sunaku's keymap snippet")
else:
    with open(os.path.join(output_dir, "custom-behaviors.h"), "w") as f:
        f.write(cdb)
    print(f"  {output_dir}/custom-behaviors.h  - full custom defined behaviors")

# 2. Extract custom_devicetree
cdt = data.get("custom_devicetree", "")
if cdt:
    with open(os.path.join(output_dir, "devicetree.dtsi"), "w") as f:
        f.write(cdt)
    print(f"  {output_dir}/devicetree.dtsi    - custom devicetree")

# 3. Extract layer names + layers as readable text
layer_names = data.get("layer_names", [])
layers = data.get("layers", [])
with open(os.path.join(output_dir, "layers.json"), "w") as f:
    json.dump({"layer_names": layer_names, "layers": layers}, f, indent=2)
print(f"  {output_dir}/layers.json        - layer definitions ({len(layers)} layers)")

# 4. Extract metadata (everything else)
meta = {k: v for k, v in data.items()
        if k not in ("custom_defined_behaviors", "custom_devicetree",
                      "layers", "layer_names")}
with open(os.path.join(output_dir, "metadata.json"), "w") as f:
    json.dump(meta, f, indent=2)
print(f"  {output_dir}/metadata.json      - keyboard metadata, macros, combos, etc.")

# 5. Patch snippet.h: add thumb keys to both hand lists for bilateral HRM
# This allows same-hand thumb combos (e.g. S+Backspace) to work with
# ENFORCE_BILATERAL, matching the Sofle's hold-trigger-key-positions setup.
snippet_path = os.path.join(output_dir, "snippet.h")
if os.path.exists(snippet_path):
    with open(snippet_path) as f:
        content = f.read()

    # Left thumb keys: 52 53 54 69 70 71
    # Right thumb keys: 55 56 57 72 73 74
    # Add right thumbs to LEFT_HAND_KEYS, left thumbs to RIGHT_HAND_KEYS

    # Patch LEFT_HAND_KEYS: add right thumb keys after "71 54"
    content = content.replace(
        "                        71 54\n"
        "  #define",
        "                        71 54 \\\n"
        "                      55 56 57 72 73 74\n"
        "  #define"
    )

    # Patch RIGHT_HAND_KEYS: add left thumb keys after "55 72"
    content = content.replace(
        "                                55 72\n",
        "                                55 72 \\\n"
        "                      52 53 54 69 70 71\n"
    )

    with open(snippet_path, "w") as f:
        f.write(content)
    print(f"\n  Patched {output_dir}/snippet.h - added bilateral thumb keys")

print(f"\nSplit {input_file} -> {output_dir}/")
print("Edit files, then run: python3 glove80-merge.py")
