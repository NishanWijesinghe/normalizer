#!/usr/bin/env python3

import sys

import pandas as pd
import rfc3339 as rfc  # for date object -> date string

script, encoding, error, file_location, is_debug = sys.argv


def main(encoder, errors, file_path, debug):
    try:
        input_fd = open(file_path, encoding=encoder, errors=errors, newline='')
        reader = pd.read_csv(input_fd, parse_dates=["Timestamp"], encoding=encoder, error_bad_lines=False,
                             warn_bad_lines=True)
        normalizer(reader, debug, file_path)
    except pd.errors.EmptyDataError:
        sys.stderr.write('\nERROR: File name %s is empty' % file_path)
    except FileNotFoundError:
        sys.stderr.write('\nERROR: File name %s not found' % file_path)


def normalizer(reader, debug, file_path):
    if not reader.empty:
        if debug == 'True':
            print("\n-----------------------------")
            print("UTF-8 with char replacement DataFrame")
            print(reader)
            print(reader.dtypes)
            print("-----------------------------\n")

        writer = reader

        remove_bad_rows(writer, writer["Timestamp"], pd.to_datetime)

        # Timestamp column is clean
        writer["Timestamp"] = pd.to_datetime(writer["Timestamp"]) + pd.DateOffset(hours=3)
        writer["Timestamp"] = writer["Timestamp"].apply(rfc.rfc3339)

        remove_bad_rows(writer, writer["FooDuration"], pd.Timedelta)
        remove_bad_rows(writer, writer["BarDuration"], pd.Timedelta)

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
        writer["ZIP"] = writer["ZIP"].apply(str).str[:5]

        writer["FullName"] = writer["FullName"].str.upper()

        if debug == 'True':
            print("\n-----------------------------")
            print("normalized DataFrame")
            print(writer)
            print(writer.dtypes)
            print("-----------------------------\n")
            print(writer["TotalDuration"])

        output_file_name = '%s_OUTPUT.csv' % file_path \
            .replace("/", "-") \
            .replace(".-data-", "") \
            .replace(".", "") \
            .replace("/", "") \
            .replace("-", "") \
            .replace("inputs", "") \
            .replace("csv", "")

        writer.to_csv(output_file_name, index=False)


def remove_bad_rows(data_frame, column_series, method_validator):
    if column_series.dtypes == object:
        # Then at least one row has bad data
        for idx, row in enumerate(column_series):
            try:
                method_validator(row)
            except (ValueError, TypeError):
                sys.stderr.write('\nWARNING: Bad Timestamp dropping row containing %s' % row)
                data_frame.drop(idx, inplace=True)


main(encoding, error, file_location, is_debug)
