#!/bin/bash

# Set the project ID and VM name
PROJECT_ID=<your_project_id>
VM_NAME=<your_vm_name>

# Get the allocated CPU and memory of the VM
CPU_ALLOC=$(gcloud compute instances describe ${VM_NAME} --project ${PROJECT_ID} --format="csv(cpuPlatform, guestCpus)" | awk -F',' '{print $2}')
MEM_ALLOC=$(gcloud compute instances describe ${VM_NAME} --project ${PROJECT_ID} --format="csv(memoryMb)" | tail -n +2)

# Get the current CPU and memory usage of the VM
CPU_USAGE=$(gcloud compute ssh ${VM_NAME} --project ${PROJECT_ID} --command "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/'" | tr -d '\r')
MEM_USAGE=$(gcloud compute ssh ${VM_NAME} --project ${PROJECT_ID} --command "free | grep Mem | awk '{print \$3/\$2 * 100.0}'" | tr -d '\r')

# Get the current date and time
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Save the data to a CSV file
echo "${DATE},${CPU_ALLOC},${MEM_ALLOC},${CPU_USAGE},${MEM_USAGE}" >> vm_data.csv
