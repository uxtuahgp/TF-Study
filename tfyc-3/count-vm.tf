data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}


resource "yandex_compute_instance" "web" {
  depends_on = [ yandex_compute_instance.db]
  count = 2
  name = "netology-develop-platform-web-${count.index+1}"
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


  metadata = {
    serial-port-enable = var.vms_md.serial
    ssh-keys           = "ubuntu:${file("~/.ssh/id_ecdsa.pub")}"
  }

}

