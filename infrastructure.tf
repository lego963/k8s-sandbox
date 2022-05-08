locals {
  subnet_cidr = cidrsubnet(var.vpc_cidr, 4, 1)
}

resource "opentelekomcloud_vpc_v1" "this" {
  name   = "${var.project}-vpc"
  cidr   = var.vpc_cidr
  shared = true
}

resource "opentelekomcloud_vpc_subnet_v1" "this" {
  name = "${var.project}-subnet"

  vpc_id     = opentelekomcloud_vpc_v1.this.id
  cidr       = local.subnet_cidr
  gateway_ip = cidrhost(local.subnet_cidr, 1)

  dns_list = ["100.125.4.25", "1.1.1.1"]
}

resource "opentelekomcloud_cce_cluster_v3" "this" {
  name        = "${var.project}-cce"
  description = "K8s sandbox for ${var.project} project"

  cluster_type = "VirtualMachine"
  flavor_id    = var.cce_flavor

  vpc_id                 = opentelekomcloud_vpc_v1.this.id
  subnet_id              = opentelekomcloud_vpc_subnet_v1.this.network_id
  container_network_type = "vpc-router"
}

data "opentelekomcloud_cce_cluster_kubeconfig_v3" "this" {
  cluster_id = opentelekomcloud_cce_cluster_v3.this.id
}

resource "local_file" "this" {
  content  = data.opentelekomcloud_cce_cluster_kubeconfig_v3.this.kubeconfig
  filename = "${path.cwd}/otc-kubeconfig.json"
}
