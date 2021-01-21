# Можно ли передать переменную окружения в ansible
Переменные окружения
Ansible позволяет работать с переменными окружения различными способами. Во-первых, если вам необходимо создать переменную окружения для удаленной учетной записи, это можно сделать, добавив строку в файл .bash_profile, например:
```
- name: Add an environment variable to the remote user's shell.
  lineinfile: dest=~/.bash_profile regexp=^ENV_VAR= line=ENV_VAR=value
```
После этого все задачи получат доступ к этим переменным окружения. Чтобы использовать переменную окружения в последующих задачах, рекомендуется использовать параметр задачи register для хранения переменной окружения в переменной Ansible:
```
- name: Add an environment variable to the remote user's shell.
  lineinfile: dest=~/.bash_profile regexp=^ENV_VAR= line=ENV_VAR=value

- name: Get the value of the environment variable we just added.
  shell: 'source ~/.bash_profile && echo $ENV_VAR'
  register: foo

- name: Print the value of the environment variable.
  debug: msg="The variable is {{ foo.stdout }}"
```
Мы используем источник ∼ /.bash_profile в строке 4, потому что Ansible необходимо убедиться, что он использует последнюю конфигурацию среды для удаленного пользователя. В некоторых случаях задачи выполняются по SSH сессии, в которой $ENV_VAR еще не определен.

Linux также будет читать глобальные переменные окружения, добавленные в /etc/environment, поэтому в них тоже можно добавить переменную:
```
- name: Add a global environment variable.
  lineinfile: dest=/etc/environment regexp=^ENV_VAR= line=ENV_VAR=value
  sudo: yes
```
В любом случае, довольно просто управлять переменными окружения на сервере с помощью lineinfile. Если для приложения требуется много переменных окружения, можно использовать copy или template с локальным файлом вместо использования lineinfile с большим списком элементов.


# Привести пример модуля и плагина в ansible
Модуль command принимает команду и аргументы, разделенные пробелом. Аргументами могут быть: chdir — переход в каталог для выполнения команды; creates — создание файла по указанному пути; removes — удаление файла по указанному пути. Модуль shell — это аналог модуля command с важным отличием: для выполнения команд используется оболочка /bin/sh. Параметры такие же, как и у модуля command — chdir, creates и removes.
Модуль script используют при необходимости копирования скрипта на удаленный хост с последующим выполнением. Поддерживаются параметры creates и removes. Модуль raw предусмотрен для использования в случаях, когда другие командные модули (command, shell и script) использовать невозможно. Этот модуль можно использовать на удаленных хостах даже без установленного Python. Модуль file предназначен для создания/удаления каталогов, символических ссылок и файлов, а также для работы с атрибутами файлов. Для управления планировщиком задач используется модуль cron. 
Connection-плагины предоставляют различные способы подключения к целевым хостам – например, ssh – для Unix, winrm – для Windows, docker – для запуска модулей внутри контейнеров. Самые распространённые – ssh (по умолчанию) и local, который используется для запуска команд локально на машине управления., Cache-плагины используются для организации хранилища (бэкендов) фактов. По умолчанию используется memory бэкенд, поэтому факты сохраняются только во время выполнения плейбука.Callback-плагины предоставляют возможность реагировать на события, которые генерирует Ansible во время выполнения плейбука. Например, вывод журнала работы Ansible на экран делается callback-плагином default, который реагирует на множество событий и выводит на экран, что происходит. Можно включить callback-плагин slack и получать информацию о ходе выполнения плейбука в канал в Slack.Lookup-плагины используются для поиска или загрузки данных из внешних источников, а также для создания циклов.Shell-плагины позволяют учитывать нюансы разного поведения оболочек на целевых устройствах. Например, bash или csh. Для Windows используется плагин powershell.Test-плагины добавляют Jinja2 тесты, которые используются в условных конструкциях.



# Развернуть nginx c lua модулем через ansible

Один из способов установить nginx c lua модулем. Это использовать Openresty, который включает в себя оба компонента.
листинг task
```yml
---
# tasks file for deploy_nginx_lua
- block: #== for Ubuntu

   - name: inst Nginx for Ubuntu
     apt: name=nginx-extras state=latest

   - name: recommended to install the following packages
     apt:
       pkg:
        - libpcre3-dev
        - libssl-dev
        - perl
        - make
        - build-essential
        - curl
   - name: Add apt key
     apt_key:
       url: https://openresty.org/package/pubkey.gpg
       state: present
     register: import_key

   - name: Add Ubuntu apt repository
     apt_repository:
      repo: "deb http://openresty.org/package/{{ ansible_distribution|lower }} {{ ansible_distribution_release }} main"
      state: present
     when: ansible_distribution == 'Ubuntu'

   - debug: msg="{{ansible_distribution}}"

   - name: Add Debian apt repository
     apt_repository:
      repo: "deb http://openresty.org/package/{{ ansible_distribution|lower }} {{ ansible_distribution_release }} openresty"
      state: present
     when: ansible_distribution == 'Debian'

   - name: Install OpenResty
     apt:
      name: openresty
      state: present
     notify: restart openresty
```
Второй способ.

Запустить скрипт. который установит nginx. подключит необходимые репозитории, и можно будет скачать и подключить необходимые модули. Вариант не закончен. Где то в скрипте нужныеще правки. находится по маршруту *./roles/deploy_nginx_lua/files/deploy_lua_nginx.sh*

Третий способ. 

Использовать nginx-extras, в этот пакет вшиты множество модулей, среди которых, есть, так называемые "модули третьих сторон"
THIRD PARTY MODULES: Auth PAM, Cache Purge, DAV Ext, Echo, Fancy Index, GeoIP2, Headers More, Embedded _Lua_, HTTP Substitutions, Nchan, Upload Progress, Upstream Fair Queue.

Четвертый способ.

Установить модуль из репозитория https://ubuntu.pkgs.org/20.04/ubuntu-universe-amd64/libnginx-mod-http-lua_1.17.10-0ubuntu1_amd64.deb.html

Для работы модуля Lua, нужен предварительно установленный модуль NDK 
Update the package index:
 sudo apt-get update
Install libnginx-mod-http-ndk deb package:
 sudo apt-get install libnginx-mod-http-ndk
затем:
sudo apt-get update
Установите пакет deb libnginx-mod-http-lua:
sudo apt-get install libnginx-mod-http-lua

Набор task. для ролии плейбука
```yml
   - name: inst Nginx for Ubuntu
     apt: name=nginx state=present

   - name: istall module NDK
     apt: name=libnginx-mod-http-ndk state=present

   - name: istall module Lua 
     apt: name=libnginx-mod-http-lua state=present
```


# Проверить работоспособность

при добавлении  блока кода:
```bash
 server {
     location /hello {
     default_type 'text/plain';

     content_by_lua 'ngx.say("Hello world!")';
```
в файл *nginx.conf* , и переходе по маршруту _localhost/hello_ , мы увидим сообщение "Hello world!"


# Установить  apache jmetr для тестирования нагрузки вебсерверов (лучше сделать через ansible и установить сервер, и воркеры на других машинах)

Название пейбука для установки Apache Jmeter : *deploy_apache.yml*. 
Listing:

```yml
---
- name: Deploy Apache Jmetr
  hosts: qa2
  become: yes

  tasks:

    - name: install Java
      apt: name=openjdk-14-jre-headless state=latest
      
    - name: сreate directory
      file: path=/tmp/jmetr state=directory

    - name: unarchive  Jmetr
      ansible.builtin.unarchive:
       src: https://ftp.byfly.by/pub/apache.org//jmeter/binaries/apache-jmeter-5.4.tgz
       dest: /tmp/jmetr
       remote_src: True
    
```