#!/bin/bash
# Usage: ./process_data.sh input.txt output.txt

input="$1"
output="$2"

# Convert input to uppercase and write to output
tr '[:lower:]' '[:upper:]' < "$input" > "$output" 