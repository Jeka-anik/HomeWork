# Final. Отработка скрипта на виртуальной машине.

На виртуальной машинке, в директории */etc/profile.d* 
```bash
rab2@rab2-vm:/etc/profile.d$ sudo nano big.sh
[sudo] пароль для rab2: 
rab2@rab2-vm:/etc/profile.d$ sudo chmod +x big.sh
rab2@rab2-vm:/etc/profile.d$ ./big.sh
```
, создаем скрипт. 

```bash
#!/bin/bash
echo "type OS:  $OSTYPE"
echo "Name OS: $HOSTNAME "
uname -a | awk ' {print $3} '
ip r l | grep wlp3s0
echo "Load Average for 15min"
cat /proc/loadavg | awk ' {print $3} '
echo "time work systems: "
uptime | awk ' {print $2, $3, $4, $5} '
echo "Memory info: "
cat /proc/meminfo | grep Mem
echo " Login users:"
w -s
```
подключаемся с хостовой машинки на виртуальную

```bash
anik@K53:~$ ssh rab2@192.168.122.94 
rab2@192.168.122.94's password: 
Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-48-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

258 обновлений могут быть установлены прямо сейчас.
113 из этих обновлений, являются обновлениями безопасности.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

тип ОС:  linux-gnu
имя ОС: rab2-vm 
5.4.0-48-generic
Load Average for 15min
0.12
время работы системы: 
up 1:13, 2 users,
использовано памяти: 
MemTotal:        2035192 kB
MemFree:          160536 kB
MemAvailable:     453172 kB
Информация об авторизованных пользователях:
 23:23:25 up  1:13,  2 users,  load average: 0,38, 0,22, 0,12
USER     TTY      FROM              IDLE WHAT
rab2     :0       :0               ?xdm?  /usr/lib/gdm3/gdm-x-session --run-s
rab2     pts/1    192.168.122.1     0.00s w -s
```

Как видим, все скрипты отрабатывают при входе машинку.
### Это успех, братцы!