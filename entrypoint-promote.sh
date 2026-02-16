#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
set_rack
resolve_release required

echo "Promoting Release $RELEASE for $INPUT_APP on $CONVOX_RACK"
convox releases promote "$RELEASE" --app "$INPUT_APP" --wait

