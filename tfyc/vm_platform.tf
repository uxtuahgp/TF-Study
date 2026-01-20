variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family var"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v3"
  description = "VM Instance Platform ID "
} 

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "VM Instance name "
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "CPU Cores"
} 

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Memory GB"
} 

variable "vm_db_fraction" {
  type        = number
  default     = 20 
  description = "CPU core fraction %"
} 

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

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "VM Instance name "
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "CPU Cores"
} 

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Memory GB"
} 

variable "vm_web_fraction" {
  type        = number
  default     = 5
  description = "CPU core fraction %"
} 

