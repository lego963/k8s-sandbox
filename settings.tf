terraform {
  required_version = ">=1.0.0"

  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = ">= 1.23.9"
    }
  }
}

provider "opentelekomcloud" {
  cloud = "tf"
}
