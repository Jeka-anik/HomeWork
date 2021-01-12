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

vm CentOS

```bash
[root@192 voting-app]# docker-compose ps
       Name                      Command               State               Ports            
--------------------------------------------------------------------------------------------
db                    docker-entrypoint.sh postgres    Up      5432/tcp                     
redis                 docker-entrypoint.sh redis ...   Up      0.0.0.0:49153->6379/tcp      
voting-app_result_1   docker-entrypoint.sh nodem ...   Up      0.0.0.0:5858->5858/tcp,      
                                                               0.0.0.0:5001->80/tcp         
voting-app_vote_1     python app.py                    Up      0.0.0.0:5000->80/tcp         
voting-app_worker_1   dotnet Worker.dll 
```

VM Ubuntu

```bash
root@dev:/tmp/voting-app# docker-compose ps
       Name                      Command              State               Ports            
-------------------------------------------------------------------------------------------
db                    docker-entrypoint.sh postgres   Exit 1                               
redis                 docker-entrypoint.sh redis      Up       0.0.0.0:49153->6379/tcp     
                      ...                                                                  
voting-app_result_1   docker-entrypoint.sh nodem      Up       0.0.0.0:5858->5858/tcp,     
                      ...                                      0.0.0.0:5001->80/tcp        
voting-app_vote_1     python app.py                   Up       0.0.0.0:5000->80/tcp        
voting-app_worker_1   dotnet Worker.dll               Up                                   
root@dev:/tmp/voting-app# 
```
Для поднятия voting-app на удаленных машинках, использовать playbook - *playcompall.yml* , листинг прилагается:
```ansible
---
- name: docker-compose project 1
  hosts: QA 
  become: yes

  tasks:

    - name: Ansible os family
      debug: var=ansible_os_family
  
    - block: # ====Block for CentOS=====
      - name: install git 
        yum:
         name:  git-all
         state: present

      - name: install pip3
        yum: name=python3-pip state=present  

      when: ansible_os_family=="RedHat"

    - block: #====Block for Debian ====
       - name: install git 
         apt:
          name:  git
          state: present

      when: ansible_os_family=="Debian"  

    - name: create folder
      file:
       path: /tmp/voting-app
       state: directory
       owner: root
       mode: '0755'
  
    - name: inst compose
      pip: 
        name: 
        - docker
        - docker-compose
        executable: pip3

    - name: git clone
      git:
       clone: yes
       repo: https://github.com/dockersamples/example-voting-app.git
       dest: /tmp/voting-app
       
   
    - name: compose up
      community.general.docker_compose:
         project_src: /tmp/voting-app
         state: present 

```
Предпологается, что на машинках установлены докер и все необходимое. если нет, использовать playbook- *playinst2.yml* для Ubuntu/Debian, и *playinst3.yml* для CentOS/RedHat

