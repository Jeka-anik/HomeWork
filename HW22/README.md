# 1. Поднять любой контейнер, положить туда файлы и сделать образ. Закинуть образ на докерах
```dockerfile
FROM ubuntu
MAINTAINER Jeka-Anik
RUN apt-get update && apt-get install -y cowsay && ln -s /usr/games/cowsay /usr/bin/cowsay
ENTRYPOINT ["cowsay"]
```


```bash
anik@K53:~/HomeWork/HW22$ docker build -t jekanik/myapp .
Sending build context to Docker daemon  3.072kB
Step 1/4 : FROM ubuntu
 ---> d70eaf7277ea
Step 2/4 : MAINTAINER Jeka-Anik
 ---> Using cache
 ---> 3e53fb49f7e5
Step 3/4 : RUN apt-get update && apt-get install -y cowsay && ln -s /usr/games/cowsay /usr/bin/cowsay
 ---> Using cache
 ---> 257830775306
Step 4/4 : ENTRYPOINT ["cowsay"]
 ---> Using cache
 ---> c89df3cb0e9f
Successfully built c89df3cb0e9f
Successfully tagged jekanik/myapp:latest
anik@K53:~/HomeWork/HW22$ docker run jekanik/myapp Muuuu
 _______
< Muuuu >
 -------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
anik@K53:~/HomeWork/HW22$ docker push jekanik/myapp 
The push refers to repository [docker.io/jekanik/myapp]
cb591c9a42fa: Pushed 
cc9d18e90faa: Pushed 
0c2689e3f920: Pushed 
47dde53750b4: Pushed 
latest: digest: sha256:8b94aad5fdc3c56bc54545ae0cd0519f3c07c9cb0062bc2e1903385997050057 size: 1155
anik@K53:~/HomeWork/HW22$ 
```
ссылка на Докерхаб
<https://hub.docker.com/r/jekanik/myapp>

# 2. Один ли слой будет при run apt-get на разных строках
Смотря как еще написать на разных стоках
если 
```dockerfile
RUN apt-get update
RUN apt-get install 
#то на разных слоях
#если 
RUN apt-get update && apt-get install 
#то один слой 
```
