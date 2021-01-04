
# 1) Установить для диска с домашними папками квоту для пользователя системы в 100 Мб мягкую.
```bash
anik@K53:~$ sudo apt install quota
anik@K53:~$ quota --version
Версия утилиты Quota 4.05
Скомпилировано с использованием:  USE_LDAP_MAIL_LOOKUP EXT2_DIRECT HOSTS_ACCESS RPC RPC_SETQUOTA BSD_BEHAVIOUR
Ошибка в: jack@suse.cz
anik@K53:~$ find /lib/modules/`uname -r` -type f -name '*quota_v*.ko*'
/lib/modules/5.4.0-52-generic/kernel/fs/quota/quota_v1.ko
/lib/modules/5.4.0-52-generic/kernel/fs/quota/quota_v2.ko

anik@K53:~$ sudo vi /etc/fstab

# /etc/fstab: static file system information.
# 
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda8 during installation
UUID=8072de9a-7158-4ef1-bd61-565240533e16 /               ext4    errors=remount-ro 0       1
# /boot was on /dev/sda7 during installation
UUID=039b3850-0f80-4599-a9a7-86dc4c80825d /boot           ext2    defaults        0       2
# /home was on /dev/sda9 during installation
UUID=8f9b4c10-b2e7-44d5-a1c2-186cd606d4c3 /home           ext4    defaults,usrquota,grpquota        0       2

anik@K53:~$ sudo mount -o remount /home
anik@K53:~$ sudo mount | grep quota
/dev/sda9 on /home type ext4 (rw,relatime,quota,usrquota,grpquota)

anik@K53:~$ sudo quotacheck -favugm
anik@K53:~$ sudo quotaon -avug
/dev/sda9 [/home]: group quotas turned on
/dev/sda9 [/home]: user quotas turned on
anik@K53:~$ 
anik@K53:~$ sudo edquota -u anik
Disk quotas for user anik (uid 1000):
  Filesystem                   blocks       soft       hard     inodes     soft     hard
  /dev/sda9                  14664840        100          0      85635        0        0
```

# 2) Установить для диска с домашними папками квоту для группы пользователей системы,
# в которую входит ваш пользователй, в 100 объектов жесткую

```bash  
anik@K53:~$ groups
anik adm cdrom sudo dip plugdev kvm lpadmin lxd sambashare libvirt docker
anik@K53:~$ 
anik@K53:~$ sudo edquota -g kvm
  GNU nano 4.8                            /tmp//EdP.ajfe9Uw                                      
Disk quotas for group kvm (gid 108):
  Filesystem                   blocks       soft       hard     inodes     soft     hard
  /dev/sda9                   2719748          0          0          1        0      100
```

# 3) Копируя и вставляя файлы попробовать превысить обе квоты.

```bash
anik@K53:~$ sudo quota anik
Дисковые квоты для user anik (uid 1000): 
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
      /dev/sda9 17372960* 102400       0   6days   85984       0       0        
```

видно, что лимит превышен на 
17372960-102400= 17270560байт 

поиграл еще 
```bash
Grace period before enforcing soft limits for users:
Time units may be: days, hours, minutes, or seconds
  Filesystem             Block grace period     Inode grace period
  /dev/sda9                  5minutes              10minutes
anik@K53:~$ sudo quota anik
Дисковые квоты для user anik (uid 1000): 
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
      /dev/sda9 14762548* 102400  153600   6days   88822       0       0        
```

перестал добавлять новые файлы и ветки. вылетало сообщение о превышении диковой квоты 

```bash
anik@K53:~$ sudo quota -g 1000 
Дисковые квоты для group anik (gid 1000): 
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
      /dev/sda9 14796884       0       0           91157*      0     100 
```

видно что превышен лимит по количеству файлов 

# 4) Посмотреть отчет об использовании квот.

просмотр по юзерам
```bash
anik@K53:~$ sudo repquota -us /home
[sudo] пароль для anik: 
*** Report for user quotas on device /dev/sda9
Block grace time: 00:05; Inode grace time: 00:10
                        Space limits                File limits
User            used    soft    hard  grace    used  soft  hard  grace
----------------------------------------------------------------------
root      --    235M      0K      0K            106     0     0       
anik      +-  14445M    100M      0K   none   91066     0     0       
libvirt-qemu --   2657M      0K      0K              1     0     0       
testuser  --     16K      0K      0K              4     0     0       
```

по группам 
```bash
anik@K53:~$ sudo repquota -g /home
*** Report for group quotas on device /dev/sda9
Block grace time: 7days; Inode grace time: 7days
                        Block limits                File limits
Group           used    soft    hard  grace    used  soft  hard  grace
----------------------------------------------------------------------
root      --  240320       0       0            106     0     0       
kvm       -- 2719748       0       0              1     0   100       
anik      -+ 14791504       0       0          91066     0   100       
testuser  --      16       0       0              4     0     0       
```

# 5) Отключить квоту на носителе информации.

```bash
anik@K53:~$ sudo quotaoff -vug /home
/dev/sda9 [/home]: group quotas turned off
/dev/sda9 [/home]: user quotas turned off
anik@K53:~$ 
anik@K53:~$ sudo quotaon -vug /home
/dev/sda9 [/home]: group quotas turned on
/dev/sda9 [/home]: user quotas turned on
anik@K53:~$ 
```