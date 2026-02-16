#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
set_rack
resolve_release required

echo "Rolling back to release $RELEASE for $INPUT_APP on $CONVOX_RACK"
convox releases rollback "$RELEASE" --app "$INPUT_APP" --wait
