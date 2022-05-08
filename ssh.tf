resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "tls_public_key" "this" {
  private_key_pem = tls_private_key.this.private_key_pem
}

resource "opentelekomcloud_compute_keypair_v2" "this" {
  name       = "${var.project}-keypair"
  public_key = data.tls_public_key.this.public_key_openssh
}
