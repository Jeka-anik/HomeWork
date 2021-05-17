# Создать ansible роль для установки nginx, в роли должен быть шаблон nginx.conf.j2 (в темплейте должны быть for, if и default значения)
  Для установки nginx на удаленные машины с системами Ubuntu и CentOS, испльзовать _playbook.yml_ 
  Listing:
```
---
- name: Inst NGINX 
  hosts: QA
  become: yes
    
  roles:
   - deploy_nginx_web
```
Роль для установки nginx и деплоя Web-странички, находится в папке *roles/deploy_nginx_web*


# Разобраться с модулем docker для ansible

Разобрася, в предыдущих домашках можно посмотреть) (=



