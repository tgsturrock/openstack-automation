#!/bin/bash

# Set the OpenStack environment variables for admin
export OS_AUTH_URL=http://192.168.122.252/identity
export OS_PROJECT_ID=442a7841957741cfb277ec2741b51753
export OS_PROJECT_NAME="admin"
export OS_USER_DOMAIN_NAME=Default
export OS_USERNAME=admin
export OS_PASSWORD=ubuntu
export OS_REGION_NAME=RegionOne



# Function to check OpenStack service status
check_openstack_services() {
    openstack service list | grep -E "nova |neutron|glance|keystone" | grep -v "disabled" | wc -l
}

# Function to check if a subnet exists
function subnet_exists {
  subnet_name=$1
  openstack subnet show $subnet_name > /dev/null 2>&1
}

# Function to check if a server is running. If so, it is destroyed
server_is_running() {
    vm_name=$1
    if virsh list --state-running | grep -q "$vm_name"; then
        echo "Server $vm_name is running. Destroying it to avoid bugs..."
        virsh destroy "$vm_name"
        sleep 2
    else
        echo "Server $vm_name is shutdown."
    fi
}


# Main program starts here
echo
echo "Checking to see if nodes are running..."
echo
server_is_running control-node
server_is_running compute-node1
server_is_running compute-node2
echo
echo "----------------------------------------"

# Start VMs if not started
echo
echo "Starting Nodes..."
echo
virsh start control-node
virsh start compute-node1
virsh start compute-node2

echo "----------------------------------------"

echo
echo "Trying to contact OpenStack. This usually takes 3 tries..."
echo

# Wait for OpenStack services to be up
EXPECTED_SERVICES=4  # Number of expected services (nova, neutron, glance, keystone)
while true; do
    ACTIVE_SERVICES=$(check_openstack_services)
    if [ "$ACTIVE_SERVICES" -eq "$EXPECTED_SERVICES" ]; then
        echo "OpenStack is ready!"
        echo
        echo "----------------------------------------"
        echo
        break
    else
        echo
        echo "Waiting for OpenStack services to be available..."
        echo
        sleep 10
    fi
done

# Wait for networking to be available, sometimes bugs. Wait 5 secs seems to work
sleep 5

# Create subnets for the private network
echo "Creating subnets..."
echo
openstack subnet create --network compute-private-net --subnet-range 192.168.10.0/24 --gateway 192.168.10.1 --dns-nameserver 8.8.8.8 private-subnet-1
openstack subnet create --network compute-private-net --subnet-range 172.24.15.0/24 --gateway 172.24.15.1 --dns-nameserver 8.8.8.8 private-subnet-2

# Wait 5 secs for Network to settle
#sleep 5

# Wait for subnet 1 and 2 to be created
while true; do
  if subnet_exists private-subnet-1 && subnet_exists private-subnet-2; then
    echo
    echo "Subnets have been created successfully!"
    echo
    break
  else
    echo "Waiting for subnets to be created..."
    sleep 5
  fi
done

echo "Showing networks..."
echo
openstack network list
echo
echo "Showing subnets..."
echo
openstack subnet list

# Create stack from template and show details

echo
echo "Creating stack..."
echo
openstack stack create -t HOT_template.yaml lab2-stack --wait


echo
echo "Showing stack details..."
echo
openstack stack show lab2-stack
echo

# Delete the stack

echo "Deleting stack..."
echo
openstack stack delete lab2-stack -y --wait

# Delete the subnets
echo
echo "----------------------------------------"
echo
echo "Deleting Subnets..."
openstack subnet delete private-subnet-1
openstack subnet delete private-subnet-2

echo
echo "Subnets have been deleted!"
echo

echo "----------------------------------------"

echo
echo "Destroying nodes..."
echo


virsh destroy control-node
virsh destroy compute-node1
virsh destroy compute-node2

echo "----------------------------------------"

echo
echo "Program finished!"
echo
