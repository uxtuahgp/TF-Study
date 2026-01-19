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
