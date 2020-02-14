# Normalizer

## Runtime environment

macOS 10.15.x

file_source_dir=stdin
docker run -v file_path:container_path nishan:normalizer && 
docker exec -it 632114e79a42 /bin/bash -c "read_csv.py;" &&
docker cp output.csv

## Installing/Verifying macOS Dependencies

### Anaconda
https://docs.anaconda.com/anaconda/install/mac-os/

### Clang
On macOS, you should have Clang installed by default, which is designed 
to be a drop-in replacement for the normal compilers for C, C++, and 
other similar languages. Check whether the version is 3.3 or later
```
clang --version
```
If not

xcode-select --install

- To run:

```
./normalizer < sample.csv > output.csv

```

## Release notes

*Input* requirements & **assumptions** on [Truss](https://github.com/trussworks/truss-interview#the-problem-csv-normalization)

- document is in UTF-8. Non-UTF-8 handle by replacing with Unicode Replacement char.
    - If replaced & data invalid, then print a warning to stderr & drop row from output
    - Example: date field into something un-parseable.
- null timezone = US/Pacific
- Handle non-existent input file with graceful message
- Handled all RFC3339 date and time formats via Python datetime 
- If program does not run on Python 3, exit with message that instructs user how to install Python 3
- chmod +x on first clone
- If zip code has more than 5, truncate

* The entire CSV is in the UTF-8 character set.
* The `Timestamp` column should be formatted in RFC3339 format.
* The `Timestamp` column should be assumed to be in US/Pacific time;
  please convert it to US/Eastern.
* All `ZIP` codes should be formatted as 5 digits. If there are less
  than 5 digits, assume 0 as the prefix.
* The `FullName` column should be converted to uppercase. There will be
  non-English names.
* The `Address` column should be passed through as is, except for
  Unicode validation. Please note there are commas in the Address
  field; your CSV parsing will need to take that into account. Commas
  will only be present inside a quoted string.
* The `FooDuration` and `BarDuration` columns are in HH:MM:SS.MS
  format (where MS is milliseconds); please convert them to the
  total number of seconds expressed in floating point format.
  You should not round the result.
* The `TotalDuration` column is filled with garbage data. For each
  row, please replace the value of `TotalDuration` with the sum of
  `FooDuration` and `BarDuration`.
* The `Notes` column is free form text input by end-users; please do
  not perform any transformations on this column. If there are invalid
  UTF-8 characters, please replace them with the Unicode Replacement
  Character.



