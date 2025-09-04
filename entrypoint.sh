#!/bin/sh

# Make sure all environment variables are exported
set -a

# Make sure all INPUT_* environment variables are exported
env | grep ^INPUT_ | while read -r line; do
  export "$line"
done

# Get the value of the environment variable
value=$INPUT_ACTION

# Perform switch case based on the value
case "$value" in
  "build")
    /entrypoint-build.sh
    ;;
  "build-migrate")
    /entrypoint-build-migrate.sh
    ;;
  "create")
    /entrypoint-create.sh
    ;;
  "deploy")
    /entrypoint-deploy.sh
    ;;
  "destroy")
    /entrypoint-destroy.sh
    ;;
  "env-set")
    /entrypoint-env-set.sh
    ;;
  "find-release")
    /entrypoint-find-release.sh
    ;;
  "get-scale")
    /entrypoint-get-scale.sh
    ;;
  "get-rack-param")
    /entrypoint-get-rack-param.sh
    ;;
  "login")
    /entrypoint-login.sh
    ;;
  "login-user")
    /entrypoint-login-user.sh
    ;;
  "promote")
    /entrypoint-promote.sh
    ;;
  "rack-param")
    /entrypoint-rack-param.sh
    ;;
  "rollback")
    /entrypoint-rollback.sh
    ;;
  "run")
    /entrypoint-run.sh
    ;;
  "scale")
    /entrypoint-scale.sh
    ;;
  *)
    echo "Invalid action chosen!"
    ;;
esac
