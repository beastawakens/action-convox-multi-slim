#!/bin/sh

echo "Retrieving scale for $INPUT_SERVICE - $INPUT_APP"
output=$(convox scale --app $INPUT_APP --rack $INPUT_RACK | awk -v service="$INPUT_SERVICE" '$1 == service {print}')

# Parse the values using awk
desired=$(echo "$output" | awk '{print $2}')
running=$(echo "$output" | awk '{print $3}')
cpu=$(echo "$output" | awk '{print $4}')
memory=$(echo "$output" | awk '{print $5}')

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
