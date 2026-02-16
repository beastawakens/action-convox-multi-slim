#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
require_input "INPUT_SERVICE" "$INPUT_SERVICE"
require_input "INPUT_COMMAND" "$INPUT_COMMAND"
set_rack
resolve_release ""  # optional — no arg means not required

# Build the convox run command arguments
CONVOX_ARGS="--app \"$INPUT_APP\" --rack \"$CONVOX_RACK\" --timeout 3600"
if [ -n "$RELEASE" ]; then
  echo "Running command on $INPUT_SERVICE - $INPUT_APP for release $RELEASE"
  CONVOX_ARGS="--release \"$RELEASE\" $CONVOX_ARGS"
else
  echo "Running command on $INPUT_SERVICE - $INPUT_APP for the latest release"
fi

# Use 'script' to allocate a pseudo-TTY. This works around a GitHub Actions
# runner change which made terminals non-interactive, breaking convox run's
# WebSocket/SPDY connection that relies on TTY detection.
#
# Without a real PTY, the convox CLI detects a non-interactive stdin, disables
# TTY mode, and the SPDY stream to the Kubernetes pod hangs or fails.
#
# Flags: -q (quiet), -e (return child exit code), -c (run command)
# /dev/null discards the typescript recording file.
set +e
script -qec "convox run $INPUT_SERVICE '$INPUT_COMMAND' $CONVOX_ARGS" /dev/null
exit_code=$?
set -e

echo "Command completed with exit code: $exit_code"
exit $exit_code