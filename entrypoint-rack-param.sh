#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_PARAMNAME" "$INPUT_PARAMNAME"
require_input "INPUT_PARAMVALUE" "$INPUT_PARAMVALUE"
set_rack

echo "Running rack params set on $CONVOX_RACK for param $INPUT_PARAMNAME"
convox rack params set "$INPUT_PARAMNAME=$INPUT_PARAMVALUE"
