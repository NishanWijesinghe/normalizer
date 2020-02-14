#!/usr/bin/env bash
output_file_array=$(find . -name '*OUTPUT*')
for f in $output_file_array
do
  echo "Copying to host $f"
  cp $f inputs/
done