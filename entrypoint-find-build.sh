#!/bin/sh
set -e

if [ -n "$INPUT_DESCRIPTION" ]
then
 export DESCRIPTION=$INPUT_DESCRIPTION
fi
if [ -z "$DESCRIPTION" ]
then
  echo "Description must be passed as input"
  exit 1
else
  echo "Finding first build with description $DESCRIPTION for $INPUT_APP on $INPUT_RACK"
  export CONVOX_RACK=$INPUT_RACK
  build=$(convox builds --app $INPUT_APP | grep $DESCRIPTION | awk 'NR==1 {print $1}')
fi

echo "BUILD=$build" >> $GITHUB_OUTPUT
echo "BUILD=$build" >> $GITHUB_ENV
