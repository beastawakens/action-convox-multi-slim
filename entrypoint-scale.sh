#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
require_input "INPUT_SERVICE" "$INPUT_SERVICE"
require_input "INPUT_COUNT" "$INPUT_COUNT"
set_rack

echo "Scaling $INPUT_SERVICE in $INPUT_APP to $INPUT_COUNT instances"
convox scale "$INPUT_SERVICE" --count="$INPUT_COUNT" --app "$INPUT_APP" --rack "$CONVOX_RACK"
