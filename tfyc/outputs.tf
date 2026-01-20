output "output_db_name" {
  value = yandex_compute_instance.db.name
  description = "DB instance name"
}
output "output_db_ip" {
  value = yandex_compute_instance.db.network_interface.0.nat_ip_address
  description = "DB instance external IP"
}
output "output_db_fqdn" {
  value = yandex_compute_instance.db.fqdn
  description = "DB instance fqdn"
}

output "output_web_name" {
  value = yandex_compute_instance.platform.name
  description = "DB instance name"
}
output "output_web_ip" {
  value = yandex_compute_instance.platform.network_interface.0.nat_ip_address
  description = "DB instance external IP"
}
output "output_web_fqdn" {
  value = yandex_compute_instance.platform.fqdn
  description = "DB instance fqdn"
}

output "res" {
  value = var.vms_resources.db.*
}
