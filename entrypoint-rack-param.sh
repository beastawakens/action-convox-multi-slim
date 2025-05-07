#!/bin/sh
set -x

echo "DEBUG: All INPUT_ environment variables:"
env | grep INPUT_

export CONVOX_RACK=$INPUT_RACK

echo "PARAM_NAME: $INPUT_PARAM_NAME"
echo "PARAM_VALUE: $INPUT_PARAM_VALUE"

# If the above variables are empty, try using lowercase
echo "param_name: $INPUT_param_name"
echo "param_value: $INPUT_param_value"

echo "Running rack params set on $INPUT_RACK for param $INPUT_PARAM_NAME"
convox rack params set $INPUT_PARAM_NAME=$INPUT_PARAM_VALUE
