#!/bin/bash

# Replace with your project ID
PROJECT_ID="your-project-id"

# Get a list of instances in the project
instances_output=$(gcloud compute instances list --project "$PROJECT_ID" --format "csv(name,zone,machineType,status,INTERNAL_IP,EXTERNAL_IP,disks.deviceName,disks.type,disks.sizeGb,disks.encryptionKey.rawKeyName,labels)")

# Parse the output and extract the machine type, disk type, disk name, and disk size for each instance
instances=""
while read -r line; do
    if [[ $line == NAME* ]]; then
        continue
    fi
    instance_name=$(echo "$line" | cut -d "," -f 1)
    machine_type=$(echo "$line" | cut -d "," -f 3)
    disk_type=$(echo "$line" | cut -d "," -f 8)
    disk_name=$(echo "$line" | cut -d "," -f 7)
    disk_size_gb=$(echo "$line" | cut -d "," -f 9)
    instances+="$instance_name,$machine_type,$disk_type,$disk_name,$disk_size_gb"$'\n'
done <<< "$instances_output"

# Write the instances to a CSV file
echo "Instance Name,Machine Type,Disk Type,Disk Name,Disk Size (GB)" > instances.csv
echo "$instances" >> instances.csv
