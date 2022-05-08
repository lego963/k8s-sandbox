resource "opentelekomcloud_cce_cluster_v3" "this" {
  name        = "${var.project}-cce"
  description = "K8s sandbox for ${var.project} project"

  cluster_type = "VirtualMachine"
  flavor_id    = var.cce_flavor

  vpc_id                 = opentelekomcloud_vpc_v1.this.id
  subnet_id              = opentelekomcloud_vpc_subnet_v1.this.network_id
  container_network_type = "vpc-router"
}
