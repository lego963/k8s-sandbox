resource "opentelekomcloud_cce_cluster_v3" "this" {
  name        = "${var.project}-cce"
  description = "K8s sandbox for ${var.project} project"

  cluster_type = "VirtualMachine"
  flavor_id    = var.cce_flavor
  eip          = opentelekomcloud_vpc_eip_v1.this.publicip[0].ip_address

  vpc_id                 = opentelekomcloud_vpc_v1.this.id
  subnet_id              = opentelekomcloud_vpc_subnet_v1.this.network_id
  container_network_type = "vpc-router"
}

resource "opentelekomcloud_cce_node_v3" "this" {
  count = 2

  name              = "${var.project}-node-${count.index}"
  cluster_id        = opentelekomcloud_cce_cluster_v3.this.id
  availability_zone = "eu-de-01"

  flavor_id = var.node_flavor
  key_pair  = opentelekomcloud_compute_keypair_v2.this.name

  root_volume {
    size       = 50
    volumetype = "SSD"
  }

  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}
