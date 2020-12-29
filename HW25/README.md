# Повторить все команды, которые разбирали на практике (установка nginx на ubuntu и centos)
file playunst.yml
listing:
```bash
anik@K53:~/HomeWork/HW25$ ansible-playbook playinst.yml

PLAY [Install nginx for CentOS] **********************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************
ok: [centos1]
ok: [centos2]

TASK [ensure nginx is at the latest version] *********************************************************************************************
changed: [centos2]
changed: [centos1]

TASK [nginx] *****************************************************************************************************************************
ok: [centos2]
ok: [centos1]

TASK [start nginx] ***********************************************************************************************************************
ok: [centos1]
ok: [centos2]

PLAY [Install nginx for ubuntu] **********************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************
ok: [ubuntu1]
ok: [ubuntu2]

TASK [nginx] *****************************************************************************************************************************
ok: [ubuntu1]
ok: [ubuntu2]

TASK [start nginx] ***********************************************************************************************************************
ok: [ubuntu1]
ok: [ubuntu2]

PLAY RECAP *******************************************************************************************************************************
centos1                    : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
centos2                    : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu1                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu2                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
 


# Установить докер и docker-compose на машины с убунту и на centos

```bash
anik@K53:~/HomeWork/HW25$ ansible-playbook playinst2.yml

PLAY [Install nginx for ubuntu] **********************************************************************************************************

TASK [Gathering Facts] *******************************************************************************************************************
ok: [ubuntu2]
ok: [ubuntu1]

TASK [nginx] *****************************************************************************************************************************
ok: [ubuntu1]
ok: [ubuntu2]

TASK [start nginx] ***********************************************************************************************************************
ok: [ubuntu2]
ok: [ubuntu1]

PLAY RECAP *******************************************************************************************************************************
ubuntu1                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu2                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

```bash
anik@K53:~/HomeWork/HW25$ ansible-playbook playinst3.yml

PLAY [Install Docker for CentOS] ******************************************************************************************************************************

TASK [Gathering Facts] ****************************************************************************************************************************************
ok: [centos2]
ok: [centos1]

TASK [Install yum utils] **************************************************************************************************************************************
ok: [centos2]
ok: [centos1]

TASK [Install device-mapper-persistent-data] ******************************************************************************************************************
ok: [centos2]
ok: [centos1]

TASK [Install lvm2] *******************************************************************************************************************************************
ok: [centos2]
ok: [centos1]

TASK [Add Docker repo] ****************************************************************************************************************************************
changed: [centos1]
changed: [centos2]

TASK [Enable Docker Edge repo] ********************************************************************************************************************************
[WARNING]: The value 0 (type int) in a string field was converted to u'0' (type string). If this does not look like what you expect, quote the entire value to
ensure it does not change.
changed: [centos1]
changed: [centos2]

TASK [Enable Docker Test repo] ********************************************************************************************************************************
changed: [centos1]
changed: [centos2]

TASK [Install Docker] *****************************************************************************************************************************************
changed: [centos1]
changed: [centos2]

TASK [Start Docker service] ***********************************************************************************************************************************
changed: [centos1]
changed: [centos2]

PLAY RECAP ****************************************************************************************************************************************************
centos1                    : ok=9    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
centos2                    : ok=9    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

# Развернуть приложение voting-app, используя docker-compose через ansible
