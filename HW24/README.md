# Развернуть систему управления конфигруацией ansible в докере и управлять нашими хостами

попробовать ключик аргументом передать 
```dockerfile
FROM ubuntu:18.04

RUN apt-get update 
RUN apt-get install -y software-properties-common
RUN add-apt-repository --yes -u ppa:ansible/ansible
RUN apt-get install -y ansible

RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
COPY . /etc/ansible/
CMD ansible -m ping all
```

# Развернуть 4 виртуальные машины ubuntu и создать inventory file (db и app для дев и prod). Выполнить пинг через ansible для группы дев и прод.
Развернул 4 виртуальные машины
net 192.168.122.56  netmask 255.255.255.0 
net 192.168.122.83  netmask 255.255.255.0 
net 192.168.100.40  netmask 255.255.255.0 
net 192.168.100.41  netmask 255.255.255.0 
файл hosts.txt
```

[dev]
centos1 ansible_ssh_host=192.168.100.40 
centos2 ansible_ssh_host=192.168.100.41


[prod]
ubuntu1 ansible_ssh_host=192.168.122.56 
ubuntu2 ansible_ssh_host=192.168.122.83 


[dev:vars] 
ansible_ssh_user=root
ansible_ssh_private_key_file=~/.ssh/id_rsa

[prod:vars]
ansible_ssh_user=rab2
ansible_ssh_private_key_file=~/.ssh/id_rsa
```
пингуем 
```
anik@K53:~/ansible$ ansible all -m ping
ubuntu2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
ubuntu1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
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
centos2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}

```

# Подготовить шаблон для развертывания centos

Для начала, установил CentOs 8.4 в VirtualBox
Провел базовую настройку для Vagrant 
```
useradd vagrant
passwd vagrant
Повысить привилегии пользователя в системе, это необходимо для дальнейшего использования sudo:

usermod -aG wheel vagrant
Обновить систему:
yum update -y
Настройка sudoers
Отредактировать sudoers файл: 

nano /etc/sudoers
Добавить, изменить некоторые параметры к текущему виду, изменить параметр Defaults !requiretty на:

Defaults   !requiretty
 Добавить к:

Defaults    env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"
Defaults    env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"
 Параметр:

Defaults    env_keep += "SSH_AUTH_SOCK"
 Изменить параметры группы wheel:

%wheel  ALL=(ALL) NOPASSWD: ALL
Настройка sshd
Открыть файл:

/etc/ssh/sshd_config
Изменить параметр AuthorizedKeysFile на:

AuthorizedKeysFile  %h/.ssh/authorized_keys
 Раскомментировать и выставить No у параметра UseDNS:

UseDNS no
 Перезапустить sshd:

systemctl restart sshd.service
Установка vagrant ssh ключей
После загрузки машины, войти под учетной записью vagrant, создать каталог:

mkdir .ssh && chmod 0700 .ssh/ && cd .ssh
Загрузить vagrant ключ с офф репозитория:

wget --no-check-certificate https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -O authorized_keys
Задать правильные разрешения:

chmod 0600 authorized_keys

Подключить образ в меню VirtualBox - Devices - Insert Guest Additions CD image... Далее необходимо создать папку монтирования, примонтировать в нее cdrom:

sudo mkdir /mnt/cdrom && sudo mount /dev/cdrom /mnt/cdrom && cd /mnt/cdrom
 Убедиться, что в данном каталоге есть файлы (можно использовать команду ls), запустить установку VirtualBox дополнений:

sudo ./VBoxLinuxAdditions.run
 После установки отмонтировать cdrom:

sudo umount /mnt/cdrom

anik@K53:~/ansible$ cd
anik@K53:~$ mkdir vagrant-box && cd vagrant-box
anik@K53:~/vagrant-box$ vagrant box list

anik@K53:~/vagrant-box$ vagrant package --base Cent
==> Cent: Exporting VM...
==> Cent: Compressing package to: /home/anik/vagrant-box/package.box

==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'centos8-custom' (v0) for provider: 
    box: Unpacking necessary files from: file:///home/anik/vagrant-box/package.box
==> box: Successfully added box 'centos8-custom' (v0) for 'virtualbox'!
anik@K53:~/vagrant-box$ vagrant box list
centos8-custom (virtualbox, 0)
```


# Повторить пункт 2 только в докере.
```dockerfile
FROM ubuntu:18.04

RUN apt-get update && \
apt-get install -y software-properties-common &&\
add-apt-repository --yes -u ppa:ansible/ansible &&\
apt-get install -y ansible

RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
COPY . /etc/ansible/
CMD ansible -m ping all
```
file hosts
```

[dev]
centos1 ansible_ssh_host=192.168.100.40 
centos2 ansible_ssh_host=192.168.100.41 

[prod]
ubuntu1 ansible_ssh_host=192.168.122.56 
ubuntu2 ansible_ssh_host=192.168.122.83 

[dev:vars]
ansible_ssh_user=root 
ansible_ssh_pass=" "
ansible_ssh_private_key_file=/root/.ssh/id_rsa

[prod:vars]
ansible_ssh_user=rab2 
ansible_ssh_pass=" "
ansible_ssh_private_key_file=/root/.ssh/id_rsa
```
ansible.cfg
```
[defaults]
inventory         = /etc/ansible/hosts
host_key_checking = False
private_key_file = /root/.ssh/id_rsa
ost_key_auto_add = True
```
Input

```bash
anik@K53:~/HomeWork/HW24$ docker run -i -t ansible32:latest
ubuntu1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    }, 
    "changed": false, 
    "ping": "pong"
}
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
```
