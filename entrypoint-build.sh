#!/bin/sh
echo "Building"
export CONVOX_RACK=$INPUT_RACK
if [ "$INPUT_CACHED" = "false" ]; then
  release=$(convox build --app $INPUT_APP --description "$INPUT_DESCRIPTION" --id --no-cache)
else
  release=$(convox build --app $INPUT_APP --description "$INPUT_DESCRIPTION" --id)
fi

if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo "RELEASE=$release" >> $GITHUB_OUTPUT
echo "RELEASE=$release" >> $GITHUB_ENV
