# Какие состояния есть у докер контейнера?
работающее и неработающее состояние. может быть еще на паузе
определить можно командой docker ps -a 

# Какие три компонента Докер архитектуры
Основные три компонента Докера:
1 Сервер, это демон докера, dockerd
2 RestAPI
3 и клиент, интервейс командной строки 

# Можно ли потерять данные при выходе из контейнера, стоп его или удаления. Опишите варианты.
данные в контейнере не хранятся . При остановке и последующем запуске, данные сохранятся
файловая система контейнера хранит изменения даже после полной остановки контейнера.

# Какие виды подключения диска доступны для докера?
через Docker VOLUME
есть еще MOUNT 

# Что такое dockerignore? Для чего он используется? Приведите примеры.
Файл . dockerignore является инструментом, который может использоваться для уточнения контекста сборки Docker
Используется что бы не тащить за собой в контейнер, файлы типа архивов, а это нам помогает уменьшить итоговый 
образ, что уменьшает время сборки

# Для чего используется env и arg в  Dockerfile. Описать отличия.
ENV - переменная окружения, а ARG- пользовательская переменная 
Переменные окружения заданные с помощью ENV всегда заменяют переменные с 
тем же именем заданные инструкцией ARG, Переменные ARG не сохраняются в собранном 
образе в отличае от ENV переменных, 


# Можно ли использовать json вместо yaml для docker-compose в Докере?
(Если да - как это реализовать, пример)
json использовать можно, но только без TAB-ов, ну и указать имя файла правильно
Пример 
*docker-compose -f docker-compose.json up*


# Можно ли запустить одну и ту же копию docker-compose файла в Докере на одном хосте несколько раз? Как это сделать - если можно?
в теории, можно. Главное правильно собрать докерфайл, записать 
все сервисы в файле docker-compose 

# Что такое  Docker object labels? Для чего нужны? Привести примеры.
это механизм ярлыков, для указания на различные объекты докера
Пример для изобраений *LABEL <key>=<value>*

# Создать докерфайл с nginx(который будет выводить Hello World) и передать туда в качестве аргумента лейбл build_date, также примонтировать директорию с машинки в которой будет лежать файл для nginx.
директорию примонтируем при запуски билда
```bash
docker run --name test-nginx -v /FileforNginx/:/usr/share/nginx/html:ro -d a55fa5bac4a4
anik@K53:~/HomeWork/lesson24test$ docker build -t test .
Sending build context to Docker daemon  4.096kB
Step 1/4 : FROM nginx
 ---> f35646e83998
Step 2/4 : RUN echo "Hello World"
 ---> Running in e0b1babe82be
Hello World
Removing intermediate container e0b1babe82be
 ---> 74d3ae665bb2
Step 3/4 : ARG BUILD_DATE
 ---> Running in f35495aa29ee
Removing intermediate container f35495aa29ee
 ---> ee6c5c99add9
Step 4/4 : COPY ./FileforNginx/index.html /usr/share/nginx/html
 ---> a55fa5bac4a4
Successfully built a55fa5bac4a4
Successfully tagged test:latest
```
```bash
anik@K53:~/HomeWork/lesson24test$ docker run --name testnginx -v /FileforNginx/:/usr/share/nginx/html:ro a55fa5bac4a4
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
```