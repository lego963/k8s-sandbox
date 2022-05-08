terraform {
  required_version = ">=1.0.0"

  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = ">= 1.23.9"
    }

    local = {
      version = ">=2.0.0"
    }
  }
}

provider "opentelekomcloud" {
  cloud = var.cloud
}
