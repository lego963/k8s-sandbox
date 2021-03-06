locals {
  subnet_cidr = cidrsubnet(var.vpc_cidr, 4, 1)
}

resource "opentelekomcloud_vpc_v1" "this" {
  name   = "${var.project}-vpc"
  cidr   = var.vpc_cidr
  shared = true
  tags   = var.tags
}

resource "opentelekomcloud_vpc_subnet_v1" "this" {
  name = "${var.project}-subnet"

  vpc_id     = opentelekomcloud_vpc_v1.this.id
  cidr       = local.subnet_cidr
  gateway_ip = cidrhost(local.subnet_cidr, 1)

  dns_list = ["100.125.4.25", "1.1.1.1"]

  tags = var.tags
}

resource "opentelekomcloud_vpc_eip_v1" "this" {
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    name       = "${var.project}-bandwidth"
    size       = 100
    share_type = "PER"
  }
  tags = var.tags
}
