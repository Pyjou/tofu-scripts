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
  region = "BHS3"
  alias  = "bhs3"
}

provider "openstack" {
  region = "BHS5"
  alias  = "bhs5"
}

variable "public_network_name" {
  type        = string
  default     = "Ext-Net"
  description = "The name of the public network"
}

variable "image_name" {
  type        = string
  default     = "Debian 12"
  description = "The name of the image to use for the instances"
}

variable "flavor_name" {
  type        = string
  default     = "d2-2"
  description = "The name of the flavor to use for the instances"
}

variable "keypair_name" {
  type        = string
  default     = "MAC"
  description = "The name of the keypair"
}

resource "openstack_networking_network_v2" "vrack_bhs3" {
  provider       = openstack.bhs3
  name           = "my-private-network"
  admin_state_up = "true"

  value_specs = {
    "provider:network_type"    = "vrack"
    "provider:segmentation_id" = 42
  }
}

resource "openstack_networking_network_v2" "vrack_bhs5" {
  provider       = openstack.bhs5
  name           = "my-private-network"
  admin_state_up = "true"

  value_specs = {
    "provider:network_type"    = "vrack"
    "provider:segmentation_id" = 42
  }
}

resource "openstack_networking_subnet_v2" "vrack_subnet_bhs3" {
  provider   = openstack.bhs3
  network_id = openstack_networking_network_v2.vrack_bhs3.id
  cidr       = "10.0.0.0/16"

  allocation_pool {
    start = "10.0.3.1"
    end   = "10.0.3.254"
  }
}

resource "openstack_networking_subnet_v2" "vrack_subnet_bhs5" {
  provider   = openstack.bhs5
  network_id = openstack_networking_network_v2.vrack_bhs5.id
  cidr       = "10.0.0.0/16"

  allocation_pool {
    start = "10.0.5.1"
    end   = "10.0.5.254"
  }
}

resource "openstack_compute_instance_v2" "instance_bhs3" {
  provider    = openstack.bhs3
  name        = "instance-bhs3"
  image_name  = var.image_name
  flavor_name = var.flavor_name
  key_pair    = var.keypair_name

  network {
    name = var.public_network_name
  }

  network {
    uuid = openstack_networking_network_v2.vrack_bhs3.id
  }
}

resource "openstack_compute_instance_v2" "instance_bhs5" {
  provider    = openstack.bhs5
  name        = "instance-bhs5"
  image_name  = var.image_name
  flavor_name = var.flavor_name
  key_pair    = var.keypair_name

  network {
    name = var.public_network_name
  }

  network {
    uuid = openstack_networking_network_v2.vrack_bhs5.id
  }
}

output "instance_ips_bhs3" {
  value = openstack_compute_instance_v2.instance_bhs3.*.access_ip_v4
}

output "instance_ips_bhs5" {
  value = openstack_compute_instance_v2.instance_bhs5.*.access_ip_v4
}
