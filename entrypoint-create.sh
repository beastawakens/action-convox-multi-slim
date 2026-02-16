#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
set_rack

echo "Creating App $INPUT_APP on $CONVOX_RACK"
convox apps create "$INPUT_APP" --rack "$CONVOX_RACK" --wait
