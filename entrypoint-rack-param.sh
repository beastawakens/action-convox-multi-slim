#!/bin/sh
set -x

export CONVOX_RACK=$INPUT_RACK

echo "Running rack params set on $INPUT_RACK for param $INPUT_PARAMNAME"
convox rack params set $INPUT_PARAMNAME=$INPUT_PARAMVALUE

echo "PARAM_VALUE=$output" >> $GITHUB_OUTPUT
echo "PARAM_VALUE=$output" >> $GITHUB_ENV
