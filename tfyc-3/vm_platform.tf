variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family var"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v2"
  description = "VM Instance Platform ID "
} 

variable  "vms_md" {
  type       = map
  default    = {
    serial  = 1
  }
}

