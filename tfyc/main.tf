resource "yandex_vpc_network" "develop" {
  name = var.vpc_net_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_suba_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.fraction
#    cores         = local.vm_web_cores
#    memory        = local.vm_web_memory
#    core_fraction = local.vm_web_fraction
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
  }


  metadata = {
    serial-port-enable = var.vms_md.serial
    ssh-keys           = "ubuntu:${var.vms_md.key}"
  }
/*
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
*/
}

resource "yandex_vpc_subnet" "develop_b" {
  name           = var.vpc_subb_name
  zone           = var.zone_b
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.zone_b_cidr
}

resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  zone        = var.zone_b
  platform_id = var.vm_db_platform
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources["db"].fraction
#    cores         = local.vm_db_cores
#    memory        = local.vm_db_memory
#    core_fraction = local.vm_db_fraction
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
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vms_md.serial
    ssh-keys           = "ubuntu:${var.vms_md.key}"
  }

}

