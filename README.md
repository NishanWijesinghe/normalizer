# Normalizer

Normalizes a `directory` containing one or many input CSV files.

## Runtime

Docker on macOS 10.15.x

Enter directory containing CSV file(s) when running:

```
./normalizer
```

Files in a directory are normalized. Normalized filename convention:

*  `<original_file_name>_OUTPUT.csv`

Outputs are generated in the same directory.

## Sample run

Example below normalizes directory `test/data` generating normalized files 
in `test/data`

```
 ./normalizer        
Enter directory containing one or many CSV inputs:
test/data
file(s) to be normalized in test/data
./output_test-data-unit_test_bad-date-broken-utf8.csv
./test/data/null.csv
./test/data/acceptance_sample.csv
./test/data/acceptance_test_sample-with-broken-utf8.csv
./test/data/unit_test_bad-hh.mm.ss-broken-utf8.csv
./test/data/unit_test_bad-date-broken-utf8.csv
./test/data/empty.csv
./test/data/acceptance_test_bad_zip.csv
Running docker container from public docker repo
efaf67b0ab12e0cbda87eeb291b6816da6149fca5f1ca3e2079bf612fdd33435

Normalizing ./inputs/acceptance_sample.csv
Normalizing ./inputs/acceptance_test_bad_zip.csv
Normalizing ./inputs/acceptance_test_sample-with-broken-utf8.csv
Normalizing ./inputs/empty.csv
Normalizing ./inputs/null.csv

ERROR: File name ./inputs/null.csv is empty
Normalizing ./inputs/unit_test_bad-date-broken-utf8.csv

WARNING: Bad Timestamp dropping row containing 11/ü11/11 11:11:11 AM
WARNING: Bad Timestamp dropping row containing 5/12/10? 4:48:12 PM
Normalizing ./inputs/unit_test_bad-hh.mm.ss-broken-utf8.csv

WARNING: Bad Timestamp dropping row containing 1:3�2:33.123
Copying to host ./acceptance_test_bad_zip_OUTPUT.csv

Creating normalized output CSVs in: test/data

Copying to host ./unit_test_badhhmmssbrokenutf8_OUTPUT.csv
Copying to host ./unit_test_baddatebrokenutf8_OUTPUT.csv
Copying to host ./acceptance_test_samplewithbrokenutf8_OUTPUT.csv
Copying to host ./acceptance_sample_OUTPUT.csv



```



