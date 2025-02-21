#!/bin/bash

# Echo any arguments passed to the script if DEBUG is set
if [ "$DEBUG" = "true" ]; then
  echo "Arguments: $@"
fi

# Read XML from arguments, echo the input if DEBUG is set, convert to YAML using yq, and output to stdout
input="$@"
if [ "$DEBUG" = "true" ]; then
  echo "Received input:"
  echo "$input"
fi
echo "$input" | yq -p=xml -o=yaml --xml-content-name='value' | grep -v '+@xmlns:'
