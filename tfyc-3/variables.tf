###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, fraction=number }))
  default = [
    {
      vm_name     = "netology-develop-platform-db-main"
      cpu         = 4
      ram         = 2
      disk_volume = 8
      fraction    = 20
    }, 
    {
      vm_name     = "netology-develop-platform-db-replica"
      cpu         = 2
      ram         = 1
      disk_volume = 6
      fraction    = 5
    }
  ]
}

variable "my_disks" {
  type = list(object({ name=string, type=string, size=number }))
  default = [
    {
      name = "family"
      type = "network-hdd"
      size = 5
    },
    {
      name = "hobby"
      type = "network-hdd"
      size = 2
    },
    {
      name = "work"
      type = "network-hdd"
      size = 3
    }  ]
} 

