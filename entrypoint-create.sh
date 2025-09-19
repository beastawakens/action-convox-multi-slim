#!/bin/sh
set -e
echo "Creating App $INPUT_APP on $INPUT_RACK"
export CONVOX_RACK=$INPUT_RACK
convox apps create $INPUT_APP --rack $INPUT_RACK --wait
