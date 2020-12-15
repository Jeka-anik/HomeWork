# 1 Можно ли указать в докерфайле на базе ubuntu entrypoint sleep 20 ?
Мое видение решения вопроса : 
1. собираем скрипт 
2. засовываем в ENRYPOINT 
 ```bash 
 #!/bin/bash
sleep $1
echo "Hello"
```


# 2 Создать два контейнера, с приложением и базой в разных подсетях, организовать взаимодействие. 

```bash
docker network create hw23
e0e6c6db44e65e70f0e28cbf5ddf71d0bd691d35d05a6d7e7671338c162676ca
docker run --name DB -e POSTGRES_PASSWORD=1 -d postgres
7ba9fdefd87a92f0ffbfad0af337de365deb80c8ddd88c68575058f5301d6990
anik@K53:~/HomeWork/HW23/Part2$ docker network connect hw23 DB
anik@K53:~/HomeWork/HW23/Part2$ docker run -d --name web jekanik/myapp
dbcaa859d9375e709e29966b62a81fca9e2c1c7b70bb7f58058f1a94f3cc4299
anik@K53:~/HomeWork/HW23/Part2$ docker inspect web
```

Пример пинга, когда контейнеры в разных подсетях :
```bash
anik@K53:~/HomeWork/HW23/Part2/app$ docker build .
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM alpine/httpie
 ---> d887808c6fc7
Step 2/2 : RUN ping -c4 172.19.0.2
 ---> Running in f45531ce899e
PING 172.19.0.2 (172.19.0.2): 56 data bytes

--- 172.19.0.2 ping statistics ---
4 packets transmitted, 0 packets received, 100% packet loss
The command '/bin/sh -c ping -c4 172.19.0.2' returned a non-zero code: 1
```

пример пинга, с контейнерами в одной подсети bridge
```bash
anik@K53:~/HomeWork/HW23/Part2/app$ docker build .
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM alpine/httpie
 ---> d887808c6fc7
Step 2/2 : RUN ping -c4 172.17.0.2
 ---> Running in ada7f3353dc1
PING 172.17.0.2 (172.17.0.2): 56 data bytes
64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.250 ms
64 bytes from 172.17.0.2: seq=1 ttl=64 time=0.233 ms
64 bytes from 172.17.0.2: seq=2 ttl=64 time=0.245 ms
64 bytes from 172.17.0.2: seq=3 ttl=64 time=0.207 ms

--- 172.17.0.2 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 0.207/0.233/0.250 ms
Removing intermediate container ada7f3353dc1
 ---> ad54f5a5631d
Successfully built ad54f5a5631d
```

# 3 Написать Dockerfile с приложением и разместить его в изолированной сети. И можно ли в Dockerfile создать сеть?
```bash
docker build .
Sending build context to Docker daemon  3.072kB
Step 1/3 : FROM alpine
 ---> a24bb4013296
Step 2/3 : RUN ls -al && uname
 ---> Running in a50e19e627e2
total 64
drwxr-xr-x    1 root     root          4096 Dec 14 07:38 .
drwxr-xr-x    1 root     root          4096 Dec 14 07:38 ..
-rwxr-xr-x    1 root     root             0 Dec 14 07:38 .dockerenv
drwxr-xr-x    2 root     root          4096 May 29  2020 bin
drwxr-xr-x    5 root     root           340 Dec 14 07:38 dev
drwxr-xr-x    1 root     root          4096 Dec 14 07:38 etc
drwxr-xr-x    2 root     root          4096 May 29  2020 home
drwxr-xr-x    7 root     root          4096 May 29  2020 lib
drwxr-xr-x    5 root     root          4096 May 29  2020 media
drwxr-xr-x    2 root     root          4096 May 29  2020 mnt
drwxr-xr-x    2 root     root          4096 May 29  2020 opt
dr-xr-xr-x  413 root     root             0 Dec 14 07:38 proc
drwx------    2 root     root          4096 May 29  2020 root
drwxr-xr-x    2 root     root          4096 May 29  2020 run
drwxr-xr-x    2 root     root          4096 May 29  2020 sbin
drwxr-xr-x    2 root     root          4096 May 29  2020 srv
dr-xr-xr-x   13 root     root             0 Dec 14 07:38 sys
drwxrwxrwt    2 root     root          4096 May 29  2020 tmp
drwxr-xr-x    7 root     root          4096 May 29  2020 usr
drwxr-xr-x   12 root     root          4096 May 29  2020 var
Linux
Removing intermediate container a50e19e627e2
 ---> ae47cbffc53b
Step 3/3 : RUN echo "run, Vasya run"
 ---> Running in 09c06e83e1c0
run, Vasya run
Removing intermediate container 09c06e83e1c0
 ---> 8f9f30c9dd47
Successfully built 8f9f30c9dd47
```
```bash
anik@K53:~/HomeWork/HW23/Part3$ docker run -d --network host 8f9f30c9dd47
2aef9e816eb4b4bdc7b637c7566f1e8c3f295dfb00aca8873445cab369bf63c4
```
выполнил *docker container inspect f1f59f2e1131* , где *f1f59f2e1131* это CONTAINER ID нашего запуска 
вывод части инспект:
```
"HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "host",
            "PortBindings": {},
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
```

# 4 Развернуть через docker-compose example voting app, что разбирали на лекции. Сделать тоже самое без docker-compose.

```bash
anik@K53:~/HomeWork/HW23/Part4/example-voting-app$ docker-compose up
Creating network "example-voting-app_front-tier" with the default driver
Creating network "example-voting-app_back-tier" with the default driver
Creating volume "example-voting-app_db-data" with default driver
Building vote
Step 1/7 : FROM python:2.7-alpine
 ---> 8579e446340f
Step 2/7 : WORKDIR /app
 ---> Running in ba07f36e0c14
Removing intermediate container ba07f36e0c14
 ---> 9a97f5e10230
Step 3/7 : ADD requirements.txt /app/requirements.txt
 ---> 4c6586e7ca3c
Step 4/7 : RUN pip install -r requirements.txt
 ---> Running in 0af5694d5552
DEPRECATION: Python 2.7 reached the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 is no longer maintained. A future version of pip will drop support for Python 2.7. More details about Python 2 support in pip, can be found at https://pip.pypa.io/en/latest/development/release-process/#python-2-support
Collecting Flask
  Downloading Flask-1.1.2-py2.py3-none-any.whl (94 kB)
Collecting Redis
  Downloading redis-3.5.3-py2.py3-none-any.whl (72 kB)
Collecting gunicorn
  Downloading gunicorn-19.10.0-py2.py3-none-any.whl (113 kB)
Collecting Werkzeug>=0.15
  Downloading Werkzeug-1.0.1-py2.py3-none-any.whl (298 kB)
Collecting itsdangerous>=0.24
  Downloading itsdangerous-1.1.0-py2.py3-none-any.whl (16 kB)
Collecting click>=5.1
  Downloading click-7.1.2-py2.py3-none-any.whl (82 kB)
Collecting Jinja2>=2.10.1
  Downloading Jinja2-2.11.2-py2.py3-none-any.whl (125 kB)
Collecting MarkupSafe>=0.23
  Downloading MarkupSafe-1.1.1.tar.gz (19 kB)
Building wheels for collected packages: MarkupSafe
  Building wheel for MarkupSafe (setup.py): started
  Building wheel for MarkupSafe (setup.py): finished with status 'done'
  Created wheel for MarkupSafe: filename=MarkupSafe-1.1.1-py2-none-any.whl size=12630 sha256=5c2d07dad911d28ca87d233aa2682b6cf73f3b80aa5f3643495a8ed747242f5a
  Stored in directory: /root/.cache/pip/wheels/4d/4b/bf/cce593b6a13cd17b3bf2452827317fc68dfa4c61655596028c
Successfully built MarkupSafe
Installing collected packages: Werkzeug, itsdangerous, click, MarkupSafe, Jinja2, Flask, Redis, gunicorn
Successfully installed Flask-1.1.2 Jinja2-2.11.2 MarkupSafe-1.1.1 Redis-3.5.3 Werkzeug-1.0.1 click-7.1.2 gunicorn-19.10.0 itsdangerous-1.1.0
WARNING: You are using pip version 20.0.2; however, version 20.3.1 is available.
You should consider upgrading via the '/usr/local/bin/python -m pip install --upgrade pip' command.
Removing intermediate container 0af5694d5552
 ---> e722caaf8be9
Step 5/7 : ADD . /app
 ---> c13e54035acb
Step 6/7 : EXPOSE 80
 ---> Running in 1ab6ea3a32a7
Removing intermediate container 1ab6ea3a32a7
 ---> 426388b285af
Step 7/7 : CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
 ---> Running in 31d63f0ff74d
Removing intermediate container 31d63f0ff74d
 ---> dbf074ab03d7
Successfully built dbf074ab03d7
Successfully tagged example-voting-app_vote:latest
WARNING: Image for service vote was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Building result
Step 1/9 : FROM node:10-slim
10-slim: Pulling from library/node
e50c3c9ef5a2: Pull complete
7d035f3b6068: Pull complete
f088d54f7ee0: Pull complete
ad4478cb39bc: Pull complete
8228e6e12c54: Pull complete
Digest: sha256:0b44163a31a5d4862ca5efc0a438413e0495f8feedcb28f5f924d489bfa5cf9e
Status: Downloaded newer image for node:10-slim
 ---> 47f9f86ae8b5
Step 2/9 : WORKDIR /app
 ---> Running in a8ae0255d8eb
Removing intermediate container a8ae0255d8eb
 ---> 4d6172d1e967
Step 3/9 : RUN npm install -g nodemon
 ---> Running in 143a9f4512b3
/usr/local/bin/nodemon -> /usr/local/lib/node_modules/nodemon/bin/nodemon.js

> nodemon@2.0.6 postinstall /usr/local/lib/node_modules/nodemon
> node bin/postinstall || exit 0

Love nodemon? You can now support the project via the open collective:
 > https://opencollective.com/nodemon/donate

npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@~2.1.2 (node_modules/nodemon/node_modules/chokidar/node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.1.3: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

+ nodemon@2.0.6
added 119 packages from 53 contributors in 26.371s
Removing intermediate container 143a9f4512b3
 ---> 4b3e7e7858e6
Step 4/9 : COPY package*.json ./
 ---> 378fd8954f1a
Step 5/9 : RUN npm ci  && npm cache clean --force  && mv /app/node_modules /node_modules
 ---> Running in 211c01d47864
added 108 packages in 9.366s
npm WARN using --force I sure hope you know what you are doing.
Removing intermediate container 211c01d47864
 ---> 3130e206b298
Step 6/9 : COPY . .
 ---> 08224e03e7c1
Step 7/9 : ENV PORT 80
 ---> Running in f23786d902d5
Removing intermediate container f23786d902d5
 ---> 981c005284bd
Step 8/9 : EXPOSE 80
 ---> Running in 994e48ee3cc0
Removing intermediate container 994e48ee3cc0
 ---> 5c6db82bd3d9
Step 9/9 : CMD ["node", "server.js"]
 ---> Running in 4066175a69ce
Removing intermediate container 4066175a69ce
 ---> 478c57a87d88
Successfully built 478c57a87d88
Successfully tagged example-voting-app_result:latest
WARNING: Image for service result was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Pulling redis (redis:alpine)...
alpine: Pulling from library/redis
05e7bc50f07f: Pull complete
14c9d57a1c7f: Pull complete
ccd033d7ec06: Pull complete
6ff79b059f99: Pull complete
d91237314b77: Pull complete
c47d41ba6aa8: Pull complete
Digest: sha256:3bede76551d4b92b68f6a0a21de7e2947f456ed1175a12843d68336dcf02688c
Status: Downloaded newer image for redis:alpine
Pulling db (postgres:9.4)...
9.4: Pulling from library/postgres
619014d83c02: Pull complete
7ec0fe6664f6: Pull complete
9ca7ba8f7764: Pull complete
9e1155d037e2: Pull complete
febcfb7f8870: Pull complete
8c78c79412b5: Pull complete
5a35744405c5: Pull complete
27717922e067: Pull complete
36f0c5255550: Pull complete
dbf0a396f422: Pull complete
ec4c06ea33e5: Pull complete
e8dd33eba6d1: Pull complete
51c81b3b2c20: Pull complete
2a03dd76f5d7: Pull complete
Digest: sha256:42a7a6a647a602efa9592edd1f56359800d079b93fa52c5d92244c58ac4a2ab9
Status: Downloaded newer image for postgres:9.4
Building worker
Step 1/5 : FROM microsoft/dotnet:2.0.0-sdk
2.0.0-sdk: Pulling from microsoft/dotnet
3e17c6eae66c: Pull complete
74d44b20f851: Pull complete
a156217f3fa4: Pull complete
4a1ed13b6faa: Pull complete
18842ff6b0bf: Pull complete
e857bd06f538: Pull complete
b800e4c6f9e9: Pull complete
Digest: sha256:f4ea9cdf980bb9512523a3fb88e30f2b83cce4b0cddd2972bc36685461081e2f
Status: Downloaded newer image for microsoft/dotnet:2.0.0-sdk
 ---> fde8197d13f4
Step 2/5 : WORKDIR /code
 ---> Running in b36d40394f1e
Removing intermediate container b36d40394f1e
 ---> 4593ed0f7101
Step 3/5 : ADD src/Worker /code/src/Worker
 ---> 553e95314b3f
Step 4/5 : RUN dotnet restore -v minimal src/Worker     && dotnet publish -c Release -o "./" "src/Worker/"
 ---> Running in e78335ab411d
  Restoring packages for /code/src/Worker/Worker.csproj...
  Failed to download package 'System.IO.4.1.0-rc2-24027' from 'https://api.nuget.org/v3-flatcontainer/system.io/4.1.0-rc2-24027/system.io.4.1.0-rc2-24027.nupkg'.
  The download of 'https://api.nuget.org/v3-flatcontainer/system.io/4.1.0-rc2-24027/system.io.4.1.0-rc2-24027.nupkg' timed out because no data was received for 60000ms.
    Exception of type 'System.TimeoutException' was thrown.
  Installing Microsoft.NETCore.Windows.ApiSets 1.0.1-rc2-24027.
  Installing System.Threading.Tasks.Extensions 4.0.0-rc2-24027.
  Installing runtime.native.System.IO.Compression 4.1.0-rc2-24027.
  Generating MSBuild file /code/src/Worker/obj/Worker.csproj.nuget.g.props.
  Generating MSBuild file /code/src/Worker/obj/Worker.csproj.nuget.g.targets.
  Restore completed in 1.57 min for /code/src/Worker/Worker.csproj.
Microsoft (R) Build Engine version 15.3.409.57025 for .NET Core
Copyright (C) Microsoft Corporation. All rights reserved.

  Worker -> /code/src/Worker/bin/Release/netcoreapp2.0/Worker.dll
  Worker -> /code/src/Worker/
Removing intermediate container e78335ab411d
 ---> 4551441d457e
Step 5/5 : CMD dotnet src/Worker/Worker.dll
 ---> Running in 68a3ac497ad9
Removing intermediate container 68a3ac497ad9
 ---> 83c5fb3960d9
Successfully built 83c5fb3960d9
Successfully tagged example-voting-app_worker:latest
WARNING: Image for service worker was built because it did not already exist. To rebuild this image you must use `docker-compose build` or `docker-compose up --build`.
Creating redis                       ... done
Creating db                          ... done
Creating example-voting-app_result_1 ... done
Creating example-voting-app_vote_1   ... done
Creating example-voting-app_worker_1 ... done
Attaching to db, redis, example-voting-app_vote_1, example-voting-app_result_1, example-voting-app_worker_1
db        | The files belonging to this database system will be owned by user "postgres".
db        | This user must also own the server process.
db        | 
result_1  | [nodemon] 2.0.6
db        | The database cluster will be initialized with locale "en_US.utf8".
db        | The default database encoding has accordingly been set to "UTF8".
db        | The default text search configuration will be set to "english".
db        | 
db        | Data page checksums are disabled.
db        | 
vote_1    |  * Serving Flask app "app" (lazy loading)
vote_1    |  * Environment: production
vote_1    |    WARNING: This is a development server. Do not use it in a production deployment.
vote_1    |    Use a production WSGI server instead.
vote_1    |  * Debug mode: on
result_1  | [nodemon] to restart at any time, enter `rs`
result_1  | [nodemon] watching path(s): *.*
redis     | 1:C 14 Dec 2020 08:42:25.517 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
redis     | 1:C 14 Dec 2020 08:42:25.517 # Redis version=6.0.9, bits=64, commit=00000000, modified=0, pid=1, just started
redis     | 1:C 14 Dec 2020 08:42:25.517 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
db        | fixing permissions on existing directory /var/lib/postgresql/data ... ok
vote_1    |  * Running on http://0.0.0.0:80/ (Press CTRL+C to quit)
vote_1    |  * Restarting with stat
redis     | 1:M 14 Dec 2020 08:42:25.521 * Running mode=standalone, port=6379.
redis     | 1:M 14 Dec 2020 08:42:25.522 # Server initialized
redis     | 1:M 14 Dec 2020 08:42:25.522 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
result_1  | [nodemon] watching extensions: js,mjs,json
db        | creating subdirectories ... ok
result_1  | [nodemon] starting `node server.js`
db        | selecting default max_connections ... 100
db        | selecting default shared_buffers ... 128MB
redis     | 1:M 14 Dec 2020 08:42:25.524 * Ready to accept connections
db        | selecting default timezone ... Etc/UTC
db        | selecting dynamic shared memory implementation ... posix
db        | creating configuration files ... ok
vote_1    |  * Debugger is active!
vote_1    |  * Debugger PIN: 177-626-496
worker_1  | Waiting for db
```
запустим все своими руками
сначала создадим сети
anik@K53:~/HomeWork/HW23/Part4/example-voting-app$ docker network create -d bridge front-tier
aea648853f9444ae56d5e023facf71b32f0401e37775e5f4b43c00d820f553ea
anik@K53:~/HomeWork/HW23/Part4/example-voting-app$ docker network create -d bridge back-tier
4787beece8c1bcebec73502f3f730a0cad762034e364cf4066e1fe1895785f1a
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker volume create db-datadb-data
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/vote$ docker build -t vote .
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/vote$ docker run -it -p 5000:80 -d e79428dc277e
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/result$ docker build -t result .
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/result$ docker run -it -p 5001:80 -p 5858:5858 -d cb61e3b74452
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/result$ docker build -t result .
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker build -t work .
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker run -it -d 133d21ccacea
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker run -p 6379:6379 -d redis:alpine 
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker run -it -e POSTGRES_USER=user -e POSTGRES_PASSWORD=123456 -v db-data:/var/lib/postgresql/data --link 27e91c4afcd5:27e91c4afcd5 -d postgres:9.4

попытка с линковкой

anik@K53:~/HomeWork/HW23/Part4/example-voting-app/vote$ docker run -it -p 5000:80 -d e79428dc277e
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker run -p 6379:6379 --link e10bf4b958f3:e10bf4b958f3 -d redis:alpine
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker run -it --link jolly_jennings:jolly_jennings -d 9ff2ad5274db
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/worker$ docker run -it -e POSTGRES_USER=user -e POSTGRES_PASSWORD=123456 -v db-data:/var/lib/postgresql/data --link keen_cori:keen_cori -d postgres:9.4
anik@K53:~/HomeWork/HW23/Part4/example-voting-app/result$ docker run -it -p 5001:80 -p 5858:5858 --link strange_goldstine:strange_goldstine -d cb61e3b74452


# 5 * Посмотреть, что такое multistaged docker containers. Показать реализацию.

multistaged docker containers - многоэтаная сборка , попробуем собрать сво. Для примера, собрал из старого докерфайла, новый, чуть более тяжелый 
```dockerfile
FROM ubuntu-upstart
MAINTAINER anik.evgeniy@gmail.com
COPY tasksleep.sh /tasksleep.sh
ENTRYPOINT ["/tasksleep.sh", "20"]
```
Его размер оказался : +-253мб
```bash
"Architecture": "amd64",
        "Os": "linux",
        "Size": 253283048,
        "VirtualSize": 253283048,
        "GraphDriver":
```
docker run -it --name Sleep jekanik/sweetsleep:build 
Hello
docker create --name sleepcreate jekanik/sweetsleep:build
af2037362d15bb69f696c02c2745468c842542ddb7552190362b1a6d43dad40b
sudo docker cp sleepcreate:/tasksleep.sh ./Prod/
sudo docker build --no-cache -t sleepcreate .


*В пулреквест скидывать только Dockerfile, docker-compose либо описание, как развертывали через docker run. Для каждого задания сделать свою папку, например 1,2,3  и тд (сами ответы на вопросы можно в телеграмм)*
