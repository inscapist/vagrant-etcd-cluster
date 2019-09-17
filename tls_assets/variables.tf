variable "etcd_servers" {
  description = "List of URLs used to reach etcd servers."
  type        = list(string)
  default     = ["core1", "core2", "core3"]
}

variable "certificate_validity" {
  description = "How long, in hours, are the certificates valid"
  type        = number
  default     = 8760
}

variable "asset_dir" {
  description = "Path to a directory where generated assets should be placed (contains secrets)"
  type        = string
  default     = "."
}
