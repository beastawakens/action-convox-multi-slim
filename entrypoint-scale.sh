#!/bin/sh
set -e

echo "Running scale on $INPUT_SERVICE - $INPUT_APP to $INPUT_COUNT"
convox scale $INPUT_SERVICE --count=$INPUT_COUNT --app $INPUT_APP --rack $INPUT_RACK
