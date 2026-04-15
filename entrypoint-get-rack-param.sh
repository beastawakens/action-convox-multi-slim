#!/bin/sh
set -e
. "$(cd "$(dirname "$0")" && pwd)/lib/common.sh"

require_input "INPUT_PARAMNAME" "$INPUT_PARAMNAME"
set_rack

echo "Retrieving $INPUT_PARAMNAME for $CONVOX_RACK"
output=$(convox rack params | awk -v param="$INPUT_PARAMNAME" '$1 == param {print $2}')

write_output "PARAM_VALUE" "$output"
