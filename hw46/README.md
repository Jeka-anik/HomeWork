# Развернуть Jenkins в двух вариантах на виртуалке в контейнере
Сделано. + еще и локально развернул

# Добавить git credentials в Jenkins

Сделано. Смотри *media/forTask2.png*

# Настроить Jenkins slave(чтобы джобы запускались на слейве)

Сделано . *./media/mySlaves.png* and *./media/RunTaskInSlaves.png*

# Запустить Freestyle Project и выполнить любой скрипт

```bash
Started by user Ivanovich E. O.
Running as SYSTEM
Building remotely on mySlaves (ubuntu_nginx ubuntu) in workspace /home/ubuntu/ubuntu
[ubuntu] $ /bin/sh -xe /tmp/jenkins12111946774195958574.sh
+ echo Korovka says
Korovka says
+ sleep 15
+ echo Muuuuu
Muuuuu
+ sleep 20
+ echo job name : muuJob
job name : muuJob
Finished: SUCCESS
```
# Изучить процессы сборки java и python приложений

посмотрел) 