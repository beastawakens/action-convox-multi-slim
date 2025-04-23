#!/bin/sh
echo "Setting $INPUT_ENV for app $INPUT_APP on $INPUT_RACK"
export CONVOX_RACK=$INPUT_RACK
convox env set -a $INPUT_APP --rack $INPUT_RACK $INPUT_ENV
