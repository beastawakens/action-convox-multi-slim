#!/bin/sh
set -x

if [ -n "$INPUT_RELEASE" ]
then
 export RELEASE=$INPUT_RELEASE
fi

export CONVOX_RACK=$INPUT_RACK
if [ -n "$RELEASE" ]
then
  echo "Running command on $INPUT_SERVICE - $INPUT_APP for the release $RELEASE"
  convox run $INPUT_SERVICE "$INPUT_COMMAND" --release $RELEASE --app $INPUT_APP --rack $INPUT_RACK
else
  echo "Running command on $INPUT_SERVICE - $INPUT_APP for the latest release"
  convox run $INPUT_SERVICE "$INPUT_COMMAND" --app $INPUT_APP --rack $INPUT_RACK
fi