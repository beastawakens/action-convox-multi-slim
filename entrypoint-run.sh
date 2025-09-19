#!/bin/sh
set -ex

if [ -n "$INPUT_RELEASE" ]
then
 export RELEASE=$INPUT_RELEASE
fi

# Force unbuffered output
export PYTHONUNBUFFERED=1
# Set term to ensure TTY detection works properly in container
export TERM=xterm

export CONVOX_RACK=$INPUT_RACK
if [ -n "$RELEASE" ]
then
  echo "Running command on $INPUT_SERVICE - $INPUT_APP for the release $RELEASE"
  # Add timeout and force output buffering off
  timeout 3600 stdbuf -oL -eL convox run $INPUT_SERVICE "$INPUT_COMMAND" --release $RELEASE --app $INPUT_APP --rack $INPUT_RACK --timeout 3600
  exit_code=$?
  echo "Command completed with exit code: $exit_code"
  exit $exit_code
else
  echo "Running command on $INPUT_SERVICE - $INPUT_APP for the latest release"
  # Add timeout and force output buffering off
  timeout 3600 stdbuf -oL -eL convox run $INPUT_SERVICE "$INPUT_COMMAND" --app $INPUT_APP --rack $INPUT_RACK --timeout 3600
  exit_code=$?
  echo "Command completed with exit code: $exit_code"
  exit $exit_code
fi