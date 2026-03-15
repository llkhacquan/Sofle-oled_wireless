#!/usr/bin/env python3
"""Split a Glove80 Layout Editor JSON export into editable files.

Usage: python3 glove80-split.py [input.json] [output_dir]
  Defaults: quannk.json -> config/
"""
import json
import os
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

print(f"\nSplit {input_file} -> {output_dir}/")
print("Edit files, then run: python3 glove80-merge.py")
