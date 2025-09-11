#!/bin/sh

echo "Retrieving scale for $INPUT_SERVICE - $INPUT_APP"
scale_output=$(convox scale --app $INPUT_APP --rack $INPUT_RACK | awk -v service="$INPUT_SERVICE" '$1 == service {print}')
ps_output=$(convox ps --app $INPUT_APP --rack $INPUT_RACK | awk -v service="$INPUT_SERVICE" '$2 == service {print}')

# Count running and unhealthy processes for the service
running_processes=$(printf "%s\n" "$ps_output" | awk '$3=="running"{c++} END{print c?c:0}')
pending_processes=$(printf "%s\n" "$ps_output" | awk '$3=="pending"{c++} END{print c?c:0}')
unhealthy_processes=$(printf "%s\n" "$ps_output" | awk '$3=="unhealthy"{c++} END{print c?c:0}')

echo "RUNNING_PROCESSES=$running_processes" >> $GITHUB_OUTPUT
echo "RUNNING_PROCESSES=$running_processes" >> $GITHUB_ENV
echo "PENDING_PROCESSES=$pending_processes" >> $GITHUB_OUTPUT
echo "PENDING_PROCESSES=$pending_processes" >> $GITHUB_ENV
echo "UNHEALTHY_PROCESSES=$unhealthy_processes" >> $GITHUB_OUTPUT
echo "UNHEALTHY_PROCESSES=$unhealthy_processes" >> $GITHUB_ENV

# Parse the values using awk
desired=$(echo "$scale_output" | awk '{print $2}')
running=$(echo "$scale_output" | awk '{print $3}')
cpu=$(echo "$scale_output" | awk '{print $4}')
memory=$(echo "$scale_output" | awk '{print $5}')

# If the desired value is different from the running value, set SCALING_EVENT to true
if [ "$desired" -ne "$running" ]
then
  echo "SCALING_EVENT=true" >> $GITHUB_OUTPUT
  echo "SCALING_EVENT=true" >> $GITHUB_ENV
else
  echo "SCALING_EVENT=false" >> $GITHUB_OUTPUT
  echo "SCALING_EVENT=false" >> $GITHUB_ENV
fi

echo "DESIRED=$desired" >> $GITHUB_OUTPUT
echo "DESIRED=$desired" >> $GITHUB_ENV
echo "RUNNING=$running" >> $GITHUB_OUTPUT
echo "RUNNING=$running" >> $GITHUB_ENV
echo "CPU=$cpu" >> $GITHUB_OUTPUT
echo "CPU=$cpu" >> $GITHUB_ENV
echo "MEMORY=$memory" >> $GITHUB_OUTPUT
echo "MEMORY=$memory" >> $GITHUB_ENV
