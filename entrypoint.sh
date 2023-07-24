#!/bin/sh

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
  "login")
    /entrypoint-login.sh
    ;;
  "promote")
    /entrypoint-promote.sh
    ;;
  "run")
    /entrypoint-run.sh
    ;;
  *)
    echo "Invalid action chosen!"
    ;;
esac