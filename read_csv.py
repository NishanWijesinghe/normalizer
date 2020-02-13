#!/usr/bin/env python3

import sys
import csv
import pandas as pd
import datetime as dt  # for general datetime object handling
import rfc3339 as rfc  # for date object -> date string
import iso8601 as iso  # for date string -> date object

script, encoding, error, file_location = sys.argv


def main(input_file, encoder, errors, file_path):
    # create a new data frame from CSV input
    reader = pd.read_csv(input_file, parse_dates=["Timestamp"])

    print(reader)
    print(reader.dtypes)
    print("-----------------------------")

    writer = reader

    # PST to EST
    writer["Timestamp"] = writer["Timestamp"] + pd.DateOffset(hours=3)

    # rfc3339
    writer["Timestamp"] = writer["Timestamp"].apply(rfc.rfc3339)

    writer["FooDuration"] = writer["FooDuration"].apply(pd.Timedelta)
    writer["BarDuration"] = writer["BarDuration"].apply(pd.Timedelta)

    # Total duration in HH:MM:SS.MS
    writer["TotalDuration"] = writer["FooDuration"] + writer["BarDuration"]

    # Total duration in seconds
    writer["TotalDuration"] = writer["TotalDuration"].dt.total_seconds()

    # Foo & Bar converted to seconds
    writer["FooDuration"] = writer["FooDuration"].dt.total_seconds()
    writer["BarDuration"] = writer["BarDuration"].dt.total_seconds()

    writer["ZIP"] = writer["ZIP"].apply(str).str.pad(width=5, fillchar='0')
    writer["FullName"] = writer["FullName"].str.upper()

    print(writer)
    print(writer.dtypes)

    # reader = csv.DictReader(input_file)
    # print_all(reader, encoder, errors)


def print_all(reader, encoder, errors):
    for row in reader:
        for k, v in row.items():
            output(k, v)


def output(key, value):
    """
    Transformation requirements on https://github.com/trussworks/truss-interview#the-problem-csv-normalization

    key: file names [Timestamp,Address,ZIP,FullName,FooDuration,BarDuration,TotalDuration,Notes]
    value: input field value

    :return:

    output.csv

    """
    if key == 'Timestamp':
        print(pd.Timestamp(value))
    elif key == 'Address':
        print(value)
    elif key == 'ZIP':
        print(value)
    elif key == 'FullName,':
        print(value)
    elif key == 'FooDuration':
        print(value)
    elif key == 'BarDuration':
        print(value)
    elif key == 'TotalDuration':
        print(value)
    elif key == 'Notes':
        print(value)


f = open(file_location, encoding="utf-8", newline='')

main(f, encoding, error, file_location)
# Unit tests:
# ./read_csv.py utf-8 replace tests/acceptance_sample.csv
# ./read_csv.py utf-8 replace tests/acceptance_test_sample-with-broken-utf8.csv
# ./read_csv.py big5 replace tests/acceptance_test_sample-with-broken-utf8.csv
# ./read_csv.py utf-32 replace tests/acceptance_test_sample-with-broken-utf8.csv
