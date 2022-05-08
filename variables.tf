variable "project" {
  type        = string
  description = "Name of your sandbox project"
  default     = "default"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR value for the VPC"
  default     = "192.168.0.0/16"
}

variable "cce_flavor" {
  type        = string
  description = "Flavor for CCE cluster"
  default     = "cce.s1.small"
}

variable "cloud" {
  type        = string
  description = "Name of the cloud in the clouds.yaml file"
  default     = "tf"
}

variable "tags" {
  type        = map(string)
  description = "Tags key/value pairs to associate with your infrastructure"
  default = {
    "project" = "sandbox"
  }
}
