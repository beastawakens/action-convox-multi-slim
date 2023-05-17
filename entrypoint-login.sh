#!/bin/sh
echo "Setting login credentials"
echo "CONVOX_PASSWORD=$INPUT_PASSWORD" >> $GITHUB_ENV
echo "CONVOX_HOST=$INPUT_HOST" >> $GITHUB_ENV