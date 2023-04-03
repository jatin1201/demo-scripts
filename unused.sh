#!/bin/bash

# Set your GCP project ID
PROJECT_ID="your-project-id"

# Get a list of all VM instances in the project
INSTANCE_LIST=$(gcloud compute instances list --project $PROJECT_ID --format="value(name)")

# Loop through the list of instances and check for unused disks
for INSTANCE in $INSTANCE_LIST
do
  # Get a list of disks attached to the instance
  DISK_LIST=$(gcloud compute instances describe $INSTANCE --project $PROJECT_ID --format="value(disks[].source)")

  # Loop through the list of disks and check if they are in use
  for DISK in $DISK_LIST
  do
    IN_USE=$(gcloud compute disks describe $DISK --project $PROJECT_ID --format="value(users)")
    if [ -z "$IN_USE" ]
    then
      # If the disk is not in use, print the instance name and disk name to a CSV file
      echo "$INSTANCE,$DISK" >> unused_disks.csv
    fi
  done
done
