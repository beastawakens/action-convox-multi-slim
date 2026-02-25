#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
set_rack

if [ -n "$INPUT_DESCRIPTION" ]; then
  export DESCRIPTION="$INPUT_DESCRIPTION"
fi

if [ -z "$DESCRIPTION" ]; then
  echo "::error::Description must be passed as input"
  exit 1
fi

echo "Finding first build with description '$DESCRIPTION' for $INPUT_APP on $CONVOX_RACK"
build=$(convox builds --app "$INPUT_APP" | grep "$DESCRIPTION" | awk 'NR==1 {print $1}')

write_output "BUILD" "$build"
