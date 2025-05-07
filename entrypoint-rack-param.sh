#!/bin/sh
set -x

echo "DEBUG: All INPUT_ environment variables:"
env | grep INPUT_

export CONVOX_RACK=$INPUT_RACK

echo "PARAM_NAME: $INPUT_PARAMNAME"
echo "PARAM_VALUE: $INPUT_PARAMVALUE"

echo "Running rack params set on $INPUT_RACK for param $INPUT_PARAMNAME"
convox rack params set $INPUT_PARAMNAME=$INPUT_PARAMVALUE
