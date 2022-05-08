data "opentelekomcloud_cce_cluster_kubeconfig_v3" "this" {
  cluster_id = opentelekomcloud_cce_cluster_v3.this.id
}

resource "local_file" "this" {
  content  = data.opentelekomcloud_cce_cluster_kubeconfig_v3.this.kubeconfig
  filename = "${path.cwd}/otc-kubeconfig.json"
}
