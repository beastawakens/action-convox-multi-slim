#!/bin/sh
#!/bin/sh
if [ -n "$INPUT_DESCRIPTION" ]
then
 export DESCRIPTION=$INPUT_DESCRIPTION
fi
if [ -z "$DESCRIPTION" ]
then
  echo "Description must be passed as input"
  exit 1
else
  echo "Finding first release with description $DESCRIPTION for $INPUT_APP on $INPUT_RACK"
  export CONVOX_RACK=$INPUT_RACK
  convox releases $RELEASE --app $INPUT_APP --limit 100 --wait | grep $DESCRIPTION | awk 'NR==1 {print $1}'
fi

