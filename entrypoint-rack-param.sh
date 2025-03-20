#!/bin/sh
set -x

export CONVOX_RACK=$INPUT_RACK

echo "Running rack params set on $INPUT_RACK for param $INPUT_PARAM_NAME"
convox rack params set $INPUT_PARAM_NAME=$INPUT_PARAM_VALUE
