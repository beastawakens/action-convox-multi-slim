#!/bin/sh
set -e
echo "Setting login credentials for a user. Be careful with this action!"
if [ -n "$INPUT_HOST" ]
then
    convox login $INPUT_HOST --token $INPUT_TOKEN
else
    convox login console.convox.com --token $INPUT_TOKEN
fi