#!/bin/bash

# Set the project ID
PROJECT_ID=<your_project_id>

# Get the list of VMs in the project
VM_LIST=$(gcloud compute instances list --project ${PROJECT_ID} --format="csv(name)")

# Loop through each VM in the list and fetch the machine type
for VM_NAME in ${VM_LIST}; do

  # Get the machine type of the VM
  MACHINE_TYPE=$(gcloud compute instances describe ${VM_NAME} --project ${PROJECT_ID} --format="csv(machineType)")

  # Get the current date and time
  DATE=$(date "+%Y-%m-%d %H:%M:%S")

  # Save the data to a CSV file
  echo "${DATE},${VM_NAME},${MACHINE_TYPE}" >> vm_machine_type.csv

done
