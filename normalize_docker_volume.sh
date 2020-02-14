#!/usr/bin/env bash
host_data_mapped_in_container=$(dirname -- "$0")/inputs/*
for f in $host_data_mapped_in_container; do
  if [[ "$f" == *".csv"* ]]; then
    echo "Normalizing $f"
    ./read_csv.py utf-8 replace ${f} False
  fi
done
