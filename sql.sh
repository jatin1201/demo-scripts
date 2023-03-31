#!/bin/bash

# Set the project ID for which to list Cloud SQL instances
PROJECT_ID="your-project-id"

# Set the output file path for the CSV file
OUTPUT_FILE="cloud-sql-instances.csv"

# List all Cloud SQL instances in the project and output the results in CSV format
gcloud sql instances list --project=$PROJECT_ID \
  --format="csv[no-heading](name,region,databaseVersion,tier,diskSizeGb,diskUsageBytes)" \
  | awk -F',' 'BEGIN{ OFS="," } {
    if ($4 == "db-n1-standard-1") { cpu=1; ram=3.75 }
    else if ($4 == "db-n1-standard-2") { cpu=2; ram=7.5 }
    else if ($4 == "db-n1-standard-4") { cpu=4; ram=15 }
    else if ($4 == "db-n1-standard-8") { cpu=8; ram=30 }
    else if ($4 == "db-n1-standard-16") { cpu=16; ram=60 }
    else if ($4 == "db-n1-standard-32") { cpu=32; ram=120 }
    else if ($4 == "db-n1-standard-64") { cpu=64; ram=240 }
    else if ($4 == "db-n1-standard-96") { cpu=96; ram=360 }
    print $1, $2, $3, $4, $5, $6, cpu, ram, $6/1024/1024/1024
  }' \
  | sed 's/,,/,0,/g' \
  > $OUTPUT_FILE
