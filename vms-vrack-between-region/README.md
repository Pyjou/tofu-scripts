# How to create VMs on different region with OVHcloud vRack?

In this folder, you have an exmaple of how to create vms on different region. But behind the same private network with OVHcloud vRack using OpenTofu. It use Openstack Provider.

## Steps to follow

1. Create a file called `main.tf` and copy the content of the file `main.tf` from this folder.
2. Replace the values of the variables`network_name`, `image_name`, `keypair_name` and `flavor_name` with the values that you want to use.
3. Run the command `tofu init` to initialize the OpenTofu working directory.
4. Run the command `tofu plan` to see the changes that will be made.
5. Run the command `tofu apply` to create the VMs.
6. Run the command `tofu output` to see the IP addresses of the VMs.

## Variables

* `network_name`: The name of the network to attach the instances to.
* `image_name`: The name of the image to use for the instances.
* `flavor_name`: The name of the flavor to use for the instances.
* `keypair_name`: The name of the keypair use to connect to instances.

## Output

* `instance_ips_bhs3`: The IP addresses of the instances in BHS3.
* `instance_ips_bhs5`: The IP addresses of the instances in BHS5.