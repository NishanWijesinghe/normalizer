# Normalizer

## Runtime

### Docker on macOS


file_source_dir=stdin
docker run -v file_path:container_path nishan:normalizer && 
docker exec -it 632114e79a42 /bin/bash -c "read_csv.py;" &&
docker cp output.csv


```

```


```
./normalizer < sample.csv > output.csv

```



