#!/usr/bin/env bash
export debug=$1
test_data=$(dirname -- "$0")/data/*
for f in $test_data; do
  if [[ "$f" == *".csv"* ]]; then
    echo "Running test $f"
    ../read_csv.py utf-8 replace ${f} $debug
  fi

done
