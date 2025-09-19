#!/bin/sh
set -ex

export CONVOX_RACK=$INPUT_RACK

echo "Retrieving $INPUT_PARAMNAME for $CONVOX_RACK"
output=$(convox rack params | awk -v param="$INPUT_PARAMNAME" '$1 == param {print $2}')

echo "PARAM_VALUE=$output" >> $GITHUB_OUTPUT
echo "PARAM_VALUE=$output" >> $GITHUB_ENV
