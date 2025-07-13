#!/bin/bash
# Usage: ./process_more.sh input.txt output.txt

input="$1"
output="$2"

# Reverse the lines of the input file and write to output
awk '{print NR ":" $0}' "$input" | tac > "$output" 