# Implementing a Virtual Infrastructure with OpenStack

## **Project Details**

This project involved the implementation of a virtual infrastructure using **OpenStack**, a powerful open-source cloud operating system. The objective was to create a realistic, multi-node cloud environment from scratch. This was achieved by setting up three core virtual machines (VMs) that serve as the foundation of the private cloud: a **control-node** and two **compute-nodes**.

The **control-node** acts as the brain of the operation, hosting all the essential OpenStack services:
* **Keystone**: Provides identity management and authentication.
* **Nova**: Manages the life cycle of virtual machines.
* **Neutron**: Handles networking, including private subnets and routing.
* **Glance**: Stores and manages virtual machine images.
* **Horizon**: Offers a user-friendly graphical dashboard for managing the cloud.
* **Heat**: An orchestration service that automates the deployment of cloud applications and resources using templates.

The two **compute-nodes** (**compute-node1** and **compute-node2**) are responsible for providing the actual computing power, running the user-facing VMs.

The IP addresses for the core infrastructure nodes are as follows:

* **control-node**: 192.168.122.252
* **compute-node1**: 192.168.122.139
* **compute-node2**: 192.168.122.123

To streamline the setup, the **DevStack** installer was used, which automates the installation and configuration of OpenStack on a single server or a multi-node environment. Access to the administrative account is provided for system management:

* **User**: `admin`
* **Password**: `ubuntu`

***

## **Automated VM Deployment**

The final phase of the project involved using OpenStack's automation capabilities to provision new VMs for end-users. This was accomplished with a **Heat orchestration template**, a YAML-formatted file that describes the desired infrastructure. The template defined the creation of four VMs, which were automatically deployed to the compute nodes. The VMs were isolated into two distinct private subnets, demonstrating OpenStack's network segmentation capabilities. 

The details of the deployed VMs and their corresponding subnets are:

* **VM1_Compute1**: 192.168.10.0/24
* **VM2_Compute1**: 172.24.15.0/24
* **VM3_Compute2**: 192.168.10.0/24
* **VM4_Compute2**: 172.24.15.0/24

***

## **Validation and Conclusion**

To validate the success of the deployment, a key step was to verify network connectivity. This was done by logging into the **Horizon dashboard** at `http://192.168.122.252/dashboard/`, accessing the console of one of the instances, and then sending a `ping` command to the other instance residing in the same private subnet. This confirmed that the VMs were correctly provisioned and could communicate with each other within their isolated network environments.
