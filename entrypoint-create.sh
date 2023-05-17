#!/bin/sh
echo "Creating App $INPUT_APP"
export CONVOX_RACK=$INPUT_RACK
convox apps create $INPUT_APP --rack $INPUT_RACK --wait
