#!/bin/bash

# Define the root directory of your RPA project
ROOT_DIR="path_to_your_rpa_project"

# Define the output file
OUTPUT_FILE="project_info.txt"

# Initialize the output file
echo "RPA Project Information" > $OUTPUT_FILE
echo "=======================" >> $OUTPUT_FILE

# Find all .yaml and .robot files and output their contents
find "$ROOT_DIR" -type f \( -name "*.yaml" -o -name "*.robot" \) | while read -r file; do
    echo "File: $file" >> $OUTPUT_FILE
    echo "Contents:" >> $OUTPUT_FILE
    sed 's/^/  /' "$file" >> $OUTPUT_FILE
    echo "----------------" >> $OUTPUT_FILE
done

echo "Project information has been gathered and saved to $OUTPUT_FILE"
