#### Task 1 ####  
Умышленно или нет в задании допущена ошибка в названии переменной vms_ssh_public_root_key, хотя на самом деле в коде используется переменная vms_ssh_root_key  
Была ошибка в названии платформы: для Intel Cascade Lake правильный platform_id - standard-v2  
Допустимое кол-во ядер (cores): 2,4  
Допустимая доля 5% именно для standard-v2,  если бы выбрал standard-v3, то следовало бы изменить и core_fraction = 20  
![YC VM](tfyc-1-1.jpg)
```
ubuntu@fhmef04mvktfbchce8mg:~$ curl ifconfig.me  
178.154.247.91  
```  
preemptible = true - означает, что машина прерываемая, машина автоматически будет отключаться  
core_fraction = 5 - 5% мощности ядра как базовый показатель предоставляемой мощности  
Параметры необходимы для экономии средств.  
#### Task 2 ####  
После замены статических значений переменными terraform plan показал что никаких изменений нет.  
#### Task 3 ####  
Для создания второй ВМ создал блок с ресурсом инстанции, в которой добавлен параметр zone/
Кроме того, для запуска ВМ в другой зоне создал переменные и ресурс - подсеть в зоне Б  с ip cidr 10.0.2.0/24
![web and db instances](tfyc-3-1.jpg)
#### Task 4 ####  
```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

output_db_fqdn = "epdbbmn9b1p1jjnfhm60.auto.internal"
output_db_ip = "51.250.108.68"
output_db_name = "netology-develop-platform-db"
output_web_fqdn = "fhmghpckpmdd915vq4ki.auto.internal"
output_web_ip = "130.193.51.220"
output_web_name = "netology-develop-platform-web"
```
#### Task 5 ####  
```
locals {
  vm_web_name = "task-5-${var.vm_web_name}"
  vm_web_cores = "${var.vm_web_cores}"
  vm_web_memory = "${var.vm_web_memory}"
  vm_web_fraction = "${var.vm_web_fraction}"
  vm_db_name = "task-5-${var.vm_db_name}"
  vm_db_cores = "${var.vm_db_cores}"
  vm_db_memory = "${var.vm_db_memory}"
  vm_db_fraction = "${var.vm_db_fraction}"
}
```
```
Outputs:

output_db_fqdn = "epdbf2q7pejhspjblfii.auto.internal"
output_db_ip = "89.169.173.54"
output_db_name = "task-5-netology-develop-platform-db"
output_web_fqdn = "fhmetrtncarccucaq5vk.auto.internal"
output_web_ip = "62.84.117.146"
output_web_name = "task-5-netology-develop-platform-web"
res = [
  {
    "cores" = 2
    "fraction" = 20
    "memory" = 4
  },
]
```

#### Task 6 ####
##### 6.1 #####
Добавил переменную в variables.tf  
```
variable "vms_resources" {
  type        = map
  default     = {
    web = {
      cores         = 2
      memory        = 2
      fraction = 5
    }
    db = {
      cores         = 2
      memory        = 4
      fraction = 20
    }
  }
}
```
Заменил источник данных для атрибутов ресурсов в main.tf  
```
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources["db"].fraction
#    cores         = local.vm_db_cores
#    memory        = local.vm_db_memory
#    core_fraction = local.vm_db_fraction
  }
```
terraform apply после таких изменений в код не произвел никаких изменений в инфраструктуру  
##### 6.2 #####
Создал переменную, которая может использоваться не только с Ubuntu  
```
variable  "vms_md" {
  type       = map
  default    = {
    serial  = 1
    key     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJl7ngD4lOf7xiZ2aQ5B9arkVXXwQ0mQ0VJizRWEnutr root@uxtu-note"
  }
}
```
В main.tf заменил хардкод значениями из map  
```
  metadata = {
    serial-port-enable = var.vms_md.serial
    ssh-keys           = "ubuntu:${var.vms_md.key}"
  }
```
##### 6.3 #####

```
/*
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJl7ngD4lOf7xiZ2aQ5B9arkVXXwQ0mQ0VJizRWEnutr root@uxtu-note"
  description = "ssh-keygen -t ed25519"
}
*/
```
```
  locals {
  vm_web_name = "task-5-${var.vm_web_name}"
#  vm_web_cores = "${var.vm_web_cores}"
#  vm_web_memory = "${var.vm_web_memory}"
#  vm_web_fraction = "${var.vm_web_fraction}"
  vm_db_name = "task-5-${var.vm_db_name}"
#  vm_db_cores = "${var.vm_db_cores}"
#  vm_db_memory = "${var.vm_db_memory}"
#  vm_db_fraction = "${var.vm_db_fraction}"
}
```

##### 6.4 #####
После коментирования в variables.tf и locals.tf изменений в проекте terraform plan не обнаружил  
```
alex@uxtu-note:~/Study/tfyc$ terraform plan
data.yandex_compute_image.ubuntu: Reading...
yandex_vpc_network.develop: Refreshing state... [id=enpqph8kl3u9kr7pv08e]
data.yandex_compute_image.ubuntu: Read complete after 0s [id=fd807i1otb8jnlok99in]
yandex_vpc_subnet.develop: Refreshing state... [id=e9bes0egel0lkdbubqll]
yandex_vpc_subnet.develop_b: Refreshing state... [id=e2l6r8i04tl4044ifr97]
yandex_compute_instance.db: Refreshing state... [id=epdbf2q7pejhspjblfii]
yandex_compute_instance.platform: Refreshing state... [id=fhmetrtncarccucaq5vk]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

```
#### Task 7* ####
1.
```
> local.test_list[2]
"production"
```  
2.
```
> length(local.test_list)
3
```  
3.
```
> local.test_map.admin
"John"
```  
4.
```  
> "${local.test_map.admin} is ${keys(local.test_map)[0]} for ${local.test_list[2]} server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} CPUs, ${local.servers.production.ram} GB memory and ${length(local.servers.production.disks)} disks"
"John is admin for production server based on OS ubuntu-20-04 with 10 CPUs, 40 GB memory and 4 disks"
```  
#### Task 8* ####
1.
```
variable "test" {
  type      = list(map(list(string)))
}
```  
2.   
```
> var.test[0].dev1[0]
"ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"
```
