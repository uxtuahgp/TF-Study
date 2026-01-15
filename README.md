### Task 1 ###  
![Terraform installed](tf-1-1.jpg)  
#### 1.2 ####  
Допустимо использовать для хранения секретов по всей видимости personal.auto.tfvars  
#### 1.3 ####  
```
      "type": "random_password",  
      "name": "random_string",  
...  
           "result": "IbfGlmk7Y1hqkSV7",  
```  
#### 1.4 ####  
resource "docker_image" - не имеет имени, а только тип  
resource "docker_container" "1nginx" обращается к ресурсу типа docker_image с именем nginx, который не объявлен, имя ресурса начинается с цифры  
name  = "example_${random_password.random_string_FAKE.resulT}" обращается к ресурсу random_string_FAKE, который не объявлен и к его атрибуту resulT , который на самом деле должен быть result   

#### 1.5 ####  
```
resource "docker_image" "nginx" {  
  name         = "nginx:latest"  
  keep_locally = true  
}  
  
resource "docker_container" "nginx" {  
  image = docker_image.nginx.image_id  
  name  = "example_${random_password.random_string.result}"  

```
```
root@uxtu-note:~/Study/devops/tf/Ex1# docker ps  
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES  
8e6e9c6c20fe   576306625d79   "/docker-entrypoint.…"   22 minutes ago   Up 22 minutes   0.0.0.0:9090->80/tcp   example_IbfGlmk7Y1hqkSV7  
```  
#### 1.6 ####
```
oot@uxtu-note:~/Study/devops/tf/Ex1# docker ps  
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES  
ea9635e7baf4   576306625d79   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:9090->80/tcp   hello_world  
```
```
resource "docker_container" "nginx" {  
  image = docker_image.nginx.image_id  
#  name  = "example_${random_password.random_string.result}"  
  name = "hello_world"  
  
  ports {  
    internal = 80  
    external = 9090  
  }  
```  
Автоматическое приенение конфигурации без предварительного просмотра плана действий может привести к бесконтрольному внесению нежелательных изменений  
Ключ может быть применен в пакетном режиме, если интерактивные действия не предполагаются, а код уже многократно проверен.  
#### 1.7 ####  
