# Normalizer

- macOS 10.15.x is the run-time environment for this solution
- To run:

```
./normalizer < sample.csv > output.csv

```

## Input

*Input* requirements & **assumptions** on [Truss](https://github.com/trussworks/truss-interview#the-problem-csv-normalization)

- document is in UTF-8. Non-UTF-8 handle by replacing with Unicode Replacement Char.
    - If that replacement makes data invalid (for example, because it turns a date field into something un-parseable), print a warning to stderr 
    - Then drop the row from output.
- null timezone = US/Pacific
- Handle non-existent input file with graceful message
- Handle all date and time format variants
- If program does not run on Python 3, exit with message that instructs user how to install Python 3
- chmod +x on first clone


## Output 

*Output* requirements & **assumptions** on [Truss](https://github.com/trussworks/truss-interview#the-problem-csv-normalization)

- All bullets verbatim on [Truss](https://github.com/trussworks/truss-interview#the-problem-csv-normalization)
- If zip has more than 5, truncate



