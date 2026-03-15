#!/usr/bin/env python3
"""Merge edited config files back into a Glove80 Layout Editor JSON.

Usage: python3 glove80-merge.py [config_dir] [output.json]
  Defaults: config/ -> quannk.json
"""
import json
import os
import sys

config_dir = sys.argv[1] if len(sys.argv) > 1 else "config"
output_file = sys.argv[2] if len(sys.argv) > 2 else "quannk.json"

# 1. Load metadata
with open(os.path.join(config_dir, "metadata.json")) as f:
    data = json.load(f)

# 2. Rebuild custom_defined_behaviors
overrides_path = os.path.join(config_dir, "overrides.h")
snippet_path = os.path.join(config_dir, "snippet.h")
single_path = os.path.join(config_dir, "custom-behaviors.h")

if os.path.exists(overrides_path) and os.path.exists(snippet_path):
    with open(overrides_path) as f:
        overrides = f.read().rstrip()
    with open(snippet_path) as f:
        snippet = f.read()
    data["custom_defined_behaviors"] = overrides + "\n\n" + snippet
elif os.path.exists(single_path):
    with open(single_path) as f:
        data["custom_defined_behaviors"] = f.read()

# 3. Load custom_devicetree
dt_path = os.path.join(config_dir, "devicetree.dtsi")
if os.path.exists(dt_path):
    with open(dt_path) as f:
        data["custom_devicetree"] = f.read()

# 4. Load layers
with open(os.path.join(config_dir, "layers.json")) as f:
    layers_data = json.load(f)
data["layer_names"] = layers_data["layer_names"]
data["layers"] = layers_data["layers"]

# 5. Write output (compact, matching Glove80 editor format)
with open(output_file, "w") as f:
    json.dump(data, f, ensure_ascii=True)

print(f"Merged {config_dir}/ -> {output_file}")
print("Upload this file to the Glove80 Layout Editor.")
