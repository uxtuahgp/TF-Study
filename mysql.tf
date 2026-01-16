terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
  required_version = "~>1.12.0" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {
  context = "yaubuntu"
}


resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_root_pass" {
  length      = 16
  min_special = 1
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "mysql_user_pass" {
  length      = 16
  min_special = 1
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql_${random_password.random_string.result}"
  ports {
    internal = 3306
    external = 33066
  }
  env = [ "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_pass.result}", "MYSQL_DATABASE=wordpress", "MYSQL_USER=wordpress", "MYSQL_PASSWORD=${random_password.mysql_user_pass.result}", "MYSQL_ROOT_HOST='%'" ]
}

