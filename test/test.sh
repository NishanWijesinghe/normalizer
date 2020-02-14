#!/usr/bin/env bash
test_data=$(dirname -- "$0")/data/*
for f in $test_data; do
  if [[ "$f" == *".csv"* ]]; then
    echo "Running test $f"
    ../read_csv.py utf-8 replace ${f} False
  fi

done
