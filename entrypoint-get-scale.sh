#!/bin/sh

echo "Retrieving scale on $INPUT_SERVICE - $INPUT_APP to $INPUT_COUNT"
output=$(convox scale $INPUT_SERVICE --app $INPUT_APP --rack $INPUT_RACK)

# Parse the values using awk
running=$(echo "$output" | awk 'NR==2 {print $3}')
cpu=$(echo "$output" | awk 'NR==2 {print $4}')
memory=$(echo "$output" | awk 'NR==2 {print $5}')

echo "RUNNING=$running" >> $GITHUB_OUTPUT
echo "RUNNING=$running" >> $GITHUB_ENV
echo "CPU=$cpu" >> $GITHUB_OUTPUT
echo "CPU=$cpu" >> $GITHUB_ENV
echo "MEMORY=$memory" >> $GITHUB_OUTPUT
echo "MEMORY=$memory" >> $GITHUB_ENV
