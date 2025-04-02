terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "3.0.0"
    }
  }
}

# You can fill this variables
# Or just use OS_* env vars.
provider "openstack" {
  user_name = ""
  tenant_id = ""
  region    = ""
  auth_url  = ""
  password  = ""
}

# Define variables
variable "instance_count" {
  type        = number
  default     = 5
  description = "The number of instances to create"
}

variable "network_name" {
  type        = string
  default     = "MyPublicNetwork"
  description = "The name of the network to attach the instances to"
}

variable "image_name" {
  type        = string
  default     = "Debian 12"
  description = "The name of the image to use for the instances"
}

variable "flavor_name" {
  type        = string
  default     = "xx.yyy.zzz"
  description = "The name of the flavor to use for the instances"
}

resource "openstack_compute_instance_v2" "instance" {
  count       = var.instance_count
  name        = "instance-${count.index}"
  image_name  = var.image_name
  flavor_name = var.flavor_name

  network {
    name = var.network_name
  }
}

output "instance_ips" {
  value = openstack_compute_instance_v2.instance.*.access_ip_v4
}
