#!/bin/sh
echo "Setting login credentials for a user. Be careful with this action!"
if [ -n "$INPUT_HOST" ]
then
    convox login $INPUT_HOST -t $INPUT_TOKEN
else
    convox login console.convox.com -t $INPUT_TOKEN
fi