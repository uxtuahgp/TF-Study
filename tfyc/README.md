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
