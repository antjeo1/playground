#!/bin/bash

# Create data directory if it doesn't exist
mkdir -p data

# Read URLs from config.yaml
urls=$(yq '.urls[]' config.yaml)

# Iterate through URLs
for url in $urls; do
  # Fetch the pom.xml file
  curl -s $url -o pom.xml

  # Extract groupId and artifactId from the pom.xml
  groupId=$(yq -r '.project.groupId' pom.xml)
  artifactId=$(yq -r '.project.artifactId' pom.xml)

  # Convert the pom.xml to YAML and save it in the data directory
  yq -oy '.' pom.xml > data/${groupId}.${artifactId}.yaml

  echo "Processed $url and saved to data/${groupId}.${artifactId}.yaml"
done

# Clean up
rm pom.xml