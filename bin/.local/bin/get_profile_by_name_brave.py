#!/usr/bin/env python

import json
import os
from pathlib import Path
import sys

def generate_error(error_message: str) -> None:
    print(error_message, file=sys.stderr)
    sys.exit(1)

CONFIG_DIR = os.environ.get('XDG_CONFIG_HOME', os.path.expanduser('~/.config'))

# ~/.config/BraveSoftware/Brave-Browser/Local State
BRAVE_PROFILE_FILE = Path(CONFIG_DIR) / 'BraveSoftware' / 'Brave-Browser' / 'Local State'

if not BRAVE_PROFILE_FILE.is_file():
    generate_error("Local State is not a file")

if len(list(sys.argv)) < 2:
    generate_error("At least one argument must be passed to this script")

PROFILE_NAME = " ".join(sys.argv[1:])

with open(BRAVE_PROFILE_FILE) as json_f:
    json_file = json.load(json_f)

# "profile" > "info_cache" > "Default" > "name"
all_profiles_by_id = json_file["profile"]["info_cache"]

all_profiles_by_name = {
        profile_props["name"]: profile_id
        for profile_id, profile_props in all_profiles_by_id.items()
    }

selected_profile = all_profiles_by_name.get(PROFILE_NAME)

if selected_profile is None:
    generate_error("There is no profile with that name")

print(selected_profile)
sys.exit(0)
