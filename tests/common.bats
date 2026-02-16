#!/usr/bin/env bats

# Tests for lib/common.sh shared utility functions.
# Run with: bats tests/common.bats

setup() {
  # Provide stubs for GITHUB_OUTPUT and GITHUB_ENV
  export GITHUB_OUTPUT=$(mktemp)
  export GITHUB_ENV=$(mktemp)
}

teardown() {
  rm -f "$GITHUB_OUTPUT" "$GITHUB_ENV"
}

# ---------------------------------------------------------------------------
# require_input
# ---------------------------------------------------------------------------

@test "require_input succeeds when value is provided" {
  . lib/common.sh
  run require_input "INPUT_APP" "my-app"
  [ "$status" -eq 0 ]
}

@test "require_input fails when value is empty" {
  . lib/common.sh
  run require_input "INPUT_APP" ""
  [ "$status" -eq 1 ]
  [[ "$output" == *"INPUT_APP is required"* ]]
}

# ---------------------------------------------------------------------------
# set_rack
# ---------------------------------------------------------------------------

@test "set_rack exports CONVOX_RACK" {
  export INPUT_RACK="my-rack"
  . lib/common.sh
  set_rack
  [ "$CONVOX_RACK" = "my-rack" ]
}

@test "set_rack fails when INPUT_RACK is empty" {
  export INPUT_RACK=""
  . lib/common.sh
  run set_rack
  [ "$status" -eq 1 ]
  [[ "$output" == *"INPUT_RACK is required"* ]]
}

# ---------------------------------------------------------------------------
# set_host
# ---------------------------------------------------------------------------

@test "set_host uses INPUT_HOST when provided" {
  export INPUT_HOST="custom.convox.com"
  . lib/common.sh
  set_host
  [ "$CONVOX_HOST" = "custom.convox.com" ]
}

@test "set_host uses default when INPUT_HOST is empty" {
  export INPUT_HOST=""
  . lib/common.sh
  set_host
  [ "$CONVOX_HOST" = "console.convox.com" ]
}

# ---------------------------------------------------------------------------
# set_password
# ---------------------------------------------------------------------------

@test "set_password exports CONVOX_PASSWORD when provided" {
  export INPUT_PASSWORD="secret123"
  . lib/common.sh
  set_password
  [ "$CONVOX_PASSWORD" = "secret123" ]
}

@test "set_password does nothing when INPUT_PASSWORD is empty" {
  unset CONVOX_PASSWORD
  export INPUT_PASSWORD=""
  . lib/common.sh
  set_password
  [ -z "$CONVOX_PASSWORD" ]
}

# ---------------------------------------------------------------------------
# write_output
# ---------------------------------------------------------------------------

@test "write_output writes to GITHUB_OUTPUT" {
  . lib/common.sh
  write_output "RELEASE" "R12345"
  grep -q "RELEASE=R12345" "$GITHUB_OUTPUT"
}

@test "write_output writes to GITHUB_ENV" {
  . lib/common.sh
  write_output "RELEASE" "R12345"
  grep -q "RELEASE=R12345" "$GITHUB_ENV"
}

# ---------------------------------------------------------------------------
# build_cache_flag
# ---------------------------------------------------------------------------

@test "build_cache_flag returns --no-cache when cached is false" {
  export INPUT_CACHED="false"
  . lib/common.sh
  result=$(build_cache_flag)
  [ "$result" = "--no-cache" ]
}

@test "build_cache_flag returns empty when cached is true" {
  export INPUT_CACHED="true"
  . lib/common.sh
  result=$(build_cache_flag)
  [ -z "$result" ]
}

# ---------------------------------------------------------------------------
# build_manifest_flag
# ---------------------------------------------------------------------------

@test "build_manifest_flag returns -m path when manifest is set" {
  export INPUT_MANIFEST="custom/convox.yml"
  . lib/common.sh
  result=$(build_manifest_flag)
  [ "$result" = "-m custom/convox.yml" ]
}

@test "build_manifest_flag returns empty when manifest is unset" {
  export INPUT_MANIFEST=""
  . lib/common.sh
  result=$(build_manifest_flag)
  [ -z "$result" ]
}

# ---------------------------------------------------------------------------
# resolve_release
# ---------------------------------------------------------------------------

@test "resolve_release uses INPUT_RELEASE when provided" {
  export INPUT_RELEASE="R99999"
  . lib/common.sh
  resolve_release
  [ "$RELEASE" = "R99999" ]
}

@test "resolve_release keeps existing RELEASE when INPUT_RELEASE is empty" {
  export INPUT_RELEASE=""
  export RELEASE="R11111"
  . lib/common.sh
  resolve_release
  [ "$RELEASE" = "R11111" ]
}

@test "resolve_release fails when required and no release available" {
  export INPUT_RELEASE=""
  unset RELEASE
  . lib/common.sh
  run resolve_release required
  [ "$status" -eq 1 ]
  [[ "$output" == *"Release must"* ]]
}

@test "resolve_release succeeds when required and INPUT_RELEASE is set" {
  export INPUT_RELEASE="R55555"
  . lib/common.sh
  run resolve_release required
  [ "$status" -eq 0 ]
}

# ---------------------------------------------------------------------------
# entrypoint.sh dispatcher
# ---------------------------------------------------------------------------

@test "entrypoint.sh exits 1 for invalid action" {
  export INPUT_ACTION="nonexistent-action"
  run sh entrypoint.sh
  [ "$status" -eq 1 ]
  [[ "$output" == *"Invalid action"* ]]
}
