#!/bin/sh
set -e
echo "Setting login credentials"
echo "CONVOX_PASSWORD=$INPUT_PASSWORD" >> $GITHUB_ENV
if [ -n "$INPUT_HOST" ]
then
    echo "CONVOX_HOST=$INPUT_HOST" >> $GITHUB_ENV
else
    echo "CONVOX_HOST=console.convox.com" >> $GITHUB_ENV
fi