# Copilot Instructions for action-convox-multi-slim

## Project Overview

This is a **Docker-based GitHub Action** that wraps the Convox CLI into a single reusable action supporting 16 different commands. It uses a dispatcher pattern where `entrypoint.sh` routes the `action` input to individual `entrypoint-{action}.sh` scripts.

## Architecture

```
entrypoint.sh          — Main dispatcher (case switch on INPUT_ACTION)
lib/common.sh          — Shared utility functions (set_rack, write_output, etc.)
entrypoint-{action}.sh — One script per supported Convox command
action.yml             — GitHub Action interface definition (inputs/outputs)
Dockerfile             — Container image based on Ubuntu 22.04 + Convox CLI
```

## Key Conventions

### Adding a New Action

1. Create `entrypoint-{action-name}.sh` in the project root
2. Start the script with:
   ```sh
   #!/bin/sh
   set -e
   . /lib/common.sh
   ```
3. Validate required inputs using `require_input "INPUT_NAME" "$INPUT_NAME"`
4. Call `set_rack` if the action needs `CONVOX_RACK`
5. Use `write_output "KEY" "$value"` to set outputs (writes to both `$GITHUB_OUTPUT` and `$GITHUB_ENV`)
6. Add the case entry in `entrypoint.sh`
7. Add the action name to the `options` list in `action.yml`
8. Add any new inputs/outputs to `action.yml`
9. Update the README.md input/output tables and add a usage example

### Shell Script Rules

- Always use `set -e` (never `set -x` — it leaks secrets into logs)
- Always quote variable expansions: `"$INPUT_APP"` not `$INPUT_APP`
- Use `::error::` prefix for error messages (GitHub Actions annotation)
- Use `::add-mask::` before exposing any secret values
- Source `lib/common.sh` for shared helpers
- Output names are UPPERCASE (e.g., `RELEASE`, `DESIRED`, `PARAM_VALUE`)

### Shared Functions (lib/common.sh)

| Function | Purpose |
|----------|---------|
| `set_rack` | Exports `CONVOX_RACK` from `INPUT_RACK` (required) |
| `set_host` | Exports `CONVOX_HOST` from `INPUT_HOST` or default |
| `set_password` | Exports `CONVOX_PASSWORD` from `INPUT_PASSWORD` |
| `require_input NAME VALUE` | Fails with error if value is empty |
| `write_output KEY VALUE` | Writes to both `$GITHUB_OUTPUT` and `$GITHUB_ENV` |
| `build_cache_flag` | Returns `--no-cache` if `INPUT_CACHED=false` |
| `build_manifest_flag` | Returns `-m <path>` if `INPUT_MANIFEST` is set |
| `resolve_release [required]` | Sets `RELEASE` from `INPUT_RELEASE` or env |

### Input → Action Matrix

| Action | Required Inputs | Optional Inputs | Outputs |
|--------|----------------|-----------------|---------|
| `login` | `password` | `host` | — |
| `login-user` | `token` | `host` | — |
| `build` | `rack`, `app` | `description`, `cached`, `manifest` | `RELEASE` |
| `build-migrate` | `rack`, `app`, `destinationApp`, `destinationRack` | — | `RELEASE` |
| `deploy` | `rack`, `app` | `password`, `host`, `description`, `cached`, `manifest` | — |
| `create` | `rack`, `app` | — | — |
| `destroy` | `rack`, `app` | — | — |
| `promote` | `rack`, `app`, `release` | — | — |
| `rollback` | `rack`, `app`, `release` | — | — |
| `run` | `rack`, `app`, `service`, `command` | `release` | — |
| `scale` | `rack`, `app`, `service`, `count` | — | — |
| `get-scale` | `rack`, `app`, `service` | — | `DESIRED`, `RUNNING`, `CPU`, `MEMORY`, `SCALING_EVENT`, `RUNNING_PROCESSES`, `PENDING_PROCESSES`, `UNHEALTHY_PROCESSES` |
| `env-set` | `rack`, `app`, `env` | — | — |
| `find-release` | `rack`, `app`, `description` | — | `RELEASE` |
| `get-rack-param` | `rack`, `paramName` | — | `PARAM_VALUE` |
| `rack-param` | `rack`, `paramName`, `paramValue` | — | — |

### Versioning

Versions are managed via the Makefile: `VERSION=v1.x.x make release`. This updates the Docker image tag in `action.yml` and the version label in `Dockerfile`, builds/pushes the image, and creates a signed git tag.

### Testing

Run ShellCheck locally: `shellcheck entrypoint*.sh lib/common.sh`
Run tests: `bats tests/`

### Security

- Never use `set -x` — it echoes commands containing secrets
- Always mask secrets with `::add-mask::` before writing to environment
- Quote all variables to prevent injection
