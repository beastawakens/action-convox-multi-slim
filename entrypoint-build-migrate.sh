#!/bin/sh
echo "Migrating $INPUT_APP from $INPUT_RACK to $INPUT_DESTINATIONAPP on $INPUT_DESTINATIONRACK"
export CONVOX_RACK=$INPUT_RACK

build=$(convox builds --app $INPUT_APP | grep complete | awk 'NR==1{print $1}')

if [ -z "$build" ]
then
  echo "No build found"
  exit 1
fi

release=$(convox builds export $build --app $INPUT_APP | convox builds import --app $INPUT_DESTINATIONAPP --rack $INPUT_DESTINATIONRACK)

if [ -z "$release" ]
then
  echo "Migration failed"
  exit 1
fi
echo "RELEASE=$release" >> $GITHUB_OUTPUT
echo "RELEASE=$release" >> $GITHUB_ENV
