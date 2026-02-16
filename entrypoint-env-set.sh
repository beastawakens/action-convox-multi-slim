#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
require_input "INPUT_ENV" "$INPUT_ENV"
set_rack

echo "Setting environment variables for app $INPUT_APP on $CONVOX_RACK"
# shellcheck disable=SC2086
# INPUT_ENV is intentionally word-split (key=val pairs)
convox env set -a "$INPUT_APP" --rack "$CONVOX_RACK" $INPUT_ENV
