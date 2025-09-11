#!/bin/sh

if [ -n "$INPUT_RELEASE" ]
then
 export RELEASE=$INPUT_RELEASE
fi
if [ -z "$RELEASE" ]
then
  echo "Release must be passed as input"
  exit 1
else
  echo "Rolling back to release $RELEASE for $INPUT_APP on $INPUT_RACK"
  export CONVOX_RACK=$INPUT_RACK
  convox releases rollback $RELEASE --app $INPUT_APP --wait
fi
