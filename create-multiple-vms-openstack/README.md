# How to create multiple VMs using OpenTofu

In this folder, you have an exmaple of how to create multiple VMs using OpenTofu. It use Openstack Provider.

## Steps to follow

1. Create a file called `main.tf` and copy the content of the file `main.tf` from this folder.
2. Replace the values of the variables `instance_count`, `network_name`, `image_name`, and `flavor_name` with the values that you want to use.
3. Run the command `tofu init` to initialize the OpenTofu working directory.
4. Run the command `tofu plan` to see the changes that will be made.
5. Run the command `tofu apply` to create the VMs.
6. Run the command `tofu output` to see the IP addresses of the VMs.

## Variables

* `instance_count`: The number of instances to create.
* `network_name`: The name of the network to attach the instances to.
* `image_name`: The name of the image to use for the instances.
* `flavor_name`: The name of the flavor to use for the instances.

## Output

* `instance_ips`: The IP addresses of the instances.