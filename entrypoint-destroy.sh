#!/bin/sh
echo "Destroying App $INPUT_APP on $INPUT_RACK"
export CONVOX_RACK=$INPUT_RACK
convox apps delete $INPUT_APP --rack $INPUT_RACK --wait
