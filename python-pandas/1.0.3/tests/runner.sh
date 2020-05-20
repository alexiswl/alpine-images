#!/usr/bin/env bash

# Set mounted test folder
DIRNAME=/mnt/tests

# Execute each of the scripts inside the directory
find "${DIRNAME}" -name '*.py' -exec python {} \;