#!/bin/sh
set -e
. /lib/common.sh

# Validate required inputs
require_input "INPUT_APP" "$INPUT_APP"
set_password
set_host
set_rack

echo "Deploying $INPUT_APP to $CONVOX_RACK"

# Build flag arguments
CACHED_COMMAND=$(build_cache_flag)
MANIFEST_COMMAND=$(build_manifest_flag)

# shellcheck disable=SC2086
# CACHED_COMMAND/MANIFEST_COMMAND are intentionally word-split (may be empty)
convox deploy --app "$INPUT_APP" --description "$INPUT_DESCRIPTION" $CACHED_COMMAND $MANIFEST_COMMAND --wait
