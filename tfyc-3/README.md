## Task 1 ##  
![new vpc](tfyc-3-1.jpg)  

## Task 2 ##  
### 2.1 ###
```  
  count = 2
  name = "netology-develop-platform-web-${count.index+1}"
```  
### 2.2 ###
```  
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
```  
```  
  for_each = {
    for i, vm in var.each_vm:
      i => vm
  }
  name = each.value.vm_name
  platform_id = var.vm_web_platform
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.fraction
  } 
  boot_disk {
    
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.disk_volume
    }
  }
```  
### 2.3 ###
