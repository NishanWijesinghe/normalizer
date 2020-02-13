#!/usr/bin/env python3

import sys

script, encoding, error, file_location = sys.argv


def main(input_file, encoder, errors, file_path):
    reader = input_file.readline()

    if reader:
        print_line(reader, encoder, errors)
        return main(input_file, encoder, errors, file_path)


def print_line(reader, encoder, errors):
    next_lang = reader.strip()

    raw_bytes = next_lang.encode(encoder, errors=errors)
    cooked_string = raw_bytes.decode(encoder, "replace")

    print(raw_bytes, "<===>", cooked_string)


f = open(file_location, encoding="utf-8", newline='')

main(f, encoding, error, file_location)
# Unit tests:
# ./readline.py utf-8 replace tests/unit_test_languages.txt
# ./readline.py utf-16 replace tests/unit_test_languages.txt
