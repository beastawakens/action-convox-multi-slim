#!/bin/sh
set -x

export CONVOX_RACK=$INPUT_RACK

echo "Retrieving $RACK_PARAM for $CONVOX_RACK"
output=$(convox rack params | awk -v param="$RACK_PARAM" '$1 == param {print $2}')

echo "PARAM_VALUE=$output" >> $GITHUB_OUTPUT
echo "PARAM_VALUE=$output" >> $GITHUB_ENV
