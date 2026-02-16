#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_TOKEN" "$INPUT_TOKEN"
set_host

echo "Setting login credentials for a user. Be careful with this action!"
echo "::add-mask::$INPUT_TOKEN"
convox login "$CONVOX_HOST" --token "$INPUT_TOKEN"