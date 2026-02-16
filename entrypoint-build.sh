#!/bin/sh
set -e
. /lib/common.sh

# Validate required inputs
require_input "INPUT_APP" "$INPUT_APP"
set_rack

echo "Building $INPUT_APP on $CONVOX_RACK"

# Build flag arguments
CACHED_COMMAND=$(build_cache_flag)
MANIFEST_COMMAND=$(build_manifest_flag)

# shellcheck disable=SC2086
# CACHED_COMMAND/MANIFEST_COMMAND are intentionally word-split (may be empty)
release=$(convox build --app "$INPUT_APP" --description "$INPUT_DESCRIPTION" --id $CACHED_COMMAND $MANIFEST_COMMAND)

if [ -z "$release" ]; then
  echo "::error::Build failed — convox build returned no release ID"
  exit 1
fi

write_output "RELEASE" "$release"
