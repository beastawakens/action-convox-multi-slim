#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_PASSWORD" "$INPUT_PASSWORD"
set_host

echo "Setting login credentials"

# Mask the password so it doesn't appear in logs
echo "::add-mask::$INPUT_PASSWORD"
echo "CONVOX_PASSWORD=$INPUT_PASSWORD" >> "$GITHUB_ENV"
echo "CONVOX_HOST=$CONVOX_HOST" >> "$GITHUB_ENV"