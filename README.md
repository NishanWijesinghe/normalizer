# Normalizer

Normalizer has a directory & file mode.

* Normalizes a `directory` containing [one or many input CSV files.](#directory-normalization)
* [Normalize one file.](#file-normalization)

*Runtime:* Docker on macOS 10.15.x

## Directory normalization

Enter directory containing CSV file(s) when running:

```
./normalizer
```

Files in a directory are normalized. Normalized filename convention:

*  `<original_file_name>_OUTPUT.csv`

Outputs are generated in the same directory.

### Sample directory normalization

Example below normalizes directory `test/data` generating normalized files 
in `test/data`.

`test/data` is a directory on host macOS

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

normalizer
normalizer
Running docker container from public docker repo
407986d38c8fd647dd5cf482c1dfbe3f234dbedde4a73b5c007eb3960754bd11
Normalizing ./inputs/acceptance_sample.csv
-----------> Normalized acceptance_sample_OUTPUT.csv
Normalizing ./inputs/acceptance_test_bad_zip.csv
-----------> Normalized acceptance_test_bad_zip_OUTPUT.csv
Normalizing ./inputs/acceptance_test_sample-with-broken-utf8.csv
-----------> Normalized acceptance_test_samplewithbrokenutf8_OUTPUT.csv
Normalizing ./inputs/empty.csv
Normalizing ./inputs/null.csv

ERROR: File name ./inputs/null.csv is empty
Normalizing ./inputs/unit_test_bad-date-broken-utf8.csv

WARNING: Bad Timestamp dropping row containing 11/ü11/11 11:11:11 AM

WARNING: Bad Timestamp dropping row containing 5/12/10? 4:48:12 PM
-----------> Normalized unit_test_baddatebrokenutf8_OUTPUT.csv
Normalizing ./inputs/unit_test_bad-hh.mm.ss-broken-utf8.csv

WARNING: Bad Timestamp dropping row containing 1:3�2:33.123
-----------> Normalized unit_test_badhhmmssbrokenutf8_OUTPUT.csv
Creating normalized output CSVs in: test/data
Copying to host ./acceptance_test_bad_zip_OUTPUT.csv
Copying to host ./unit_test_badhhmmssbrokenutf8_OUTPUT.csv
Copying to host ./unit_test_baddatebrokenutf8_OUTPUT.csv
Copying to host ./acceptance_test_samplewithbrokenutf8_OUTPUT.csv
Copying to host ./acceptance_sample_OUTPUT.csv
```

## File normalization

File normalizer entails:

* Copying from a sample file from host to container
* Running normalize-file in the container
* Copying normalized output from container to host

For file `sample.csv` here are the commands:

```
docker cp ../data/sample.csv normalizer:opt/normalizer/sample.csv  
docker exec -it normalizer bash -c "./normalize-file sample.csv"  
docker cp normalizer:opt/normalizer/sample_OUTPUT.csv ../data/sample_OUTPUT.csv 
```

### Sample file normalization

```
docker cp ../data/sample.csv normalizer:opt/normalizer/sample.csv              
docker exec -it normalizer bash -c "./normalize-file sample.csv"
                                              
WARNING: Bad Timestamp dropping row containing 11/ü11/11 11:11:11 AM

WARNING: Bad Timestamp dropping row containing 5/12/10? 4:48:12 PM
-----------> Normalized  sample_OUTPUT.csv
docker cp normalizer:opt/normalizer/sample_OUTPUT.csv ../data/sample_OUTPUT.csv

```
