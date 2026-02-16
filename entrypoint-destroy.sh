#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
set_rack

echo "Destroying App $INPUT_APP on $CONVOX_RACK"
convox apps delete "$INPUT_APP" --rack "$CONVOX_RACK" --wait
