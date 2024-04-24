#!/bin/sh
echo "Building $INPUT_APP on $INPUT_RACK"
export CONVOX_RACK=$INPUT_RACK

# Initialize variables for the command options
CACHED_COMMAND=""
MANIFEST_COMMAND=""

if [ "$INPUT_CACHED" = "false" ]; then
    CACHED_COMMAND="--no-cache"
fi

if [ "$INPUT_MANIFEST" != "" ]; then
    MANIFEST_COMMAND="-m $INPUT_MANIFEST"
fi

release=$(convox build --app $INPUT_APP --description "$INPUT_DESCRIPTION" --id $CACHE_COMMAND $MANIFEST_COMMAND)

if [ -z "$release" ]
then
  echo "Build failed"
  exit 1
fi
echo "RELEASE=$release" >> $GITHUB_OUTPUT
echo "RELEASE=$release" >> $GITHUB_ENV
