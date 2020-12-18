# Развернуть систему управления конфигруацией ansible в докере и управлять нашими хостами

попробовать ключик аргументом передать 

# Развернуть 4 виртуальные машины ubuntu и создать inventory file (db и app для дев и prod). Выполнить пинг через ansible для группы дев и прод.
Развернул 4 виртуальные машины
net 192.168.122.56  netmask 255.255.255.0 
net 192.168.122.83  netmask 255.255.255.0 
net 192.168.100.40  netmask 255.255.255.0 
net 192.168.100.41  netmask 255.255.255.0 
файл hosts.txt
```
[dev]
centos1 ansible_host=192.168.100.40 ansible_user=root
centos2 ansible_host=192.168.100.41 ansible_user=root
[prod]
ubuntu1 ansible_host=192.168.122.56 ansible_user=rab2
ubuntu2 ansible_host=192.168.122.83 ansible_user=rab2
```
пингуем 
```
anik@K53:~$ ansible -m ping all -i ansible/hosts.txt
ubuntu2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
centos2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
centos1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
ubuntu1 | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: ssh: connect to host 192.168.122.56 port 22: No route to host",
    "unreachable": true
}
```

# Подготовить шаблон для развертывания centos


# Повторить пункт 2 только в докере.
