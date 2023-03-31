#!/bin/bash

# Set the project ID for which to list Cloud SQL instances
PROJECT_ID="your-project-id"

# Set the output file path for the CSV file
OUTPUT_FILE="cloud-sql-instances.csv"

# List all Cloud SQL instances in the project and output the results in CSV format
gcloud sql instances list --project=$PROJECT_ID \
  --format="csv[no-heading](name,region,databaseVersion,tier,diskSizeGb,diskUsageBytes)" \
  | awk -F',' 'BEGIN{ OFS="," } { print $1, $2, $3, $4, $5, $6, $6/1024/1024/1024 }' \
  | sed 's/,,/,0,/g' \
  > $OUTPUT_FILE
