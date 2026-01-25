resource "yandex_compute_disk" "my_disks" {
  count = 3
  name = var.my_disks[count.index].name
  type = var.my_disks[count.index].type
  size = var.my_disks[count.index].size
  zone = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name = "netology-develop-platform-storage"
  platform_id = var.vm_web_platform
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  } 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  dynamic "secondary_disk" {
    for_each = var.my_disks.*.name
    content {
      disk_id     = yandex_compute_disk.my_disks[secondary_disk.key].id
      device_name = yandex_compute_disk.my_disks[secondary_disk.key].name
      auto_delete = true  
    }  
  }

  metadata = {
    serial-port-enable = var.vms_md.serial
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ecdsa.pub")}"
  }

}

