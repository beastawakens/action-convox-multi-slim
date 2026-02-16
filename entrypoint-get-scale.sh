#!/bin/sh
set -e
. /lib/common.sh

require_input "INPUT_APP" "$INPUT_APP"
require_input "INPUT_SERVICE" "$INPUT_SERVICE"
set_rack

echo "Retrieving scale for $INPUT_SERVICE - $INPUT_APP"
scale_output=$(convox scale --app "$INPUT_APP" --rack "$CONVOX_RACK" | awk -v service="$INPUT_SERVICE" '$1 == service {print}')
ps_output=$(convox ps --app "$INPUT_APP" --rack "$CONVOX_RACK" | awk -v service="$INPUT_SERVICE" '$2 == service {print}')

# Count running and unhealthy processes for the service
running_processes=$(printf "%s\n" "$ps_output" | awk '$3=="running"{c++} END{print c?c:0}')
pending_processes=$(printf "%s\n" "$ps_output" | awk '$3=="pending"{c++} END{print c?c:0}')
unhealthy_processes=$(printf "%s\n" "$ps_output" | awk '$3=="unhealthy"{c++} END{print c?c:0}')

if [ "$running_processes" -eq 0 ] && [ "$pending_processes" -eq 0 ] && [ "$unhealthy_processes" -eq 0 ]; then
  echo "::error::No processes found for service $INPUT_SERVICE in app $INPUT_APP"
  exit 1
fi

write_output "RUNNING_PROCESSES" "$running_processes"
write_output "PENDING_PROCESSES" "$pending_processes"
write_output "UNHEALTHY_PROCESSES" "$unhealthy_processes"

# Parse scale values
desired=$(echo "$scale_output" | awk '{print $2}')
running=$(echo "$scale_output" | awk '{print $3}')
cpu=$(echo "$scale_output" | awk '{print $4}')
memory=$(echo "$scale_output" | awk '{print $5}')

if [ -z "$desired" ] || [ -z "$running" ] || [ -z "$cpu" ] || [ -z "$memory" ]; then
  echo "::error::Failed to parse scale output for service $INPUT_SERVICE in app $INPUT_APP"
  exit 1
fi

# Detect if a scaling event is in progress
if [ "$desired" -ne "$running" ]; then
  write_output "SCALING_EVENT" "true"
else
  write_output "SCALING_EVENT" "false"
fi

write_output "DESIRED" "$desired"
write_output "RUNNING" "$running"
write_output "CPU" "$cpu"
write_output "MEMORY" "$memory"
