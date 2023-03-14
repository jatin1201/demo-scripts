import csv
import subprocess

# Replace with your project ID
PROJECT_ID = "your-project-id"

# Get a list of instances in the project
instances_output = subprocess.check_output(["gcloud", "compute", "instances", "list", "--project", PROJECT_ID, "--format", "csv"])

# Parse the output and extract the machine type, disk type, disk name, and disk size for each instance
instances = []
for line in instances_output.decode().split("\n")[1:]:
    if not line:
        continue
    instance_name, zone, machine_type, state, internal_ip, external_ip, disk_name, disk_type, disk_size_gb, disk_encryption, labels = line.split(",")
    instances.append((instance_name, machine_type, disk_type, disk_name, disk_size_gb))

# Write the instances to a CSV file
with open("instances.csv", "w") as csv_file:
    writer = csv.writer(csv_file)
    writer.writerow(["Instance Name", "Machine Type", "Disk Type", "Disk Name", "Disk Size (GB)"])
    for instance in instances:
        writer.writerow(instance)import csv
import subprocess

# Replace with your project ID
PROJECT_ID = "your-project-id"

# Get a list of instances in the project
instances_output = subprocess.check_output(["gcloud", "compute", "instances", "list", "--project", PROJECT_ID, "--format", "csv"])

# Parse the output and extract the machine type, disk type, disk name, and disk size for each instance
instances = []
for line in instances_output.decode().split("\n")[1:]:
    if not line:
        continue
    instance_name, zone, machine_type, state, internal_ip, external_ip, disk_name, disk_type, disk_size_gb, disk_encryption, labels = line.split(",")
    instances.append((instance_name, machine_type, disk_type, disk_name, disk_size_gb))

# Write the instances to a CSV file
with open("instances.csv", "w") as csv_file:
    writer = csv.writer(csv_file)
    writer.writerow(["Instance Name", "Machine Type", "Disk Type", "Disk Name", "Disk Size (GB)"])
    for instance in instances:
        writer.writerow(instance)
