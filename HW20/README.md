# 1) Создать скрипт, который проходит по всем аргументам которым мы передаем в скрипт и выводит их ( каждый в новой строке)

```bash
#!/bin/bash
count=1
for i in "$@"
do 
echo "parametr $count = $i"
count=$(($count+1))
done
```
Вывод:

```bash
anik@K53:~/dos-01$ ./test.sh 123 321 456 654
parametr 1 = 123
parametr 2 = 321
parametr 3 = 456
parametr 4 = 654
```


# 2) Создать скрипт, который присваивает переменной File значение TheFile - если TheFile задан. Иначе назачает переменной File /tmp/data.file. Проверка в одну строку. Использовать специальные Unset/Null операции.

```bash
#!/bin/bash 
file="$1"
if [ -n "$file" ]
then 
    echo  "file задано значение $1"
else 
    file="/tmp/data.file"
    echo " file не задан, зададим file = /tmp/data.>
    echo "значение file : $file "
fi
```
Проверяем: 
```bash
anik@K53:~/dos-01$ ./part2.sh 
 file не задан, зададим file = /tmp/data.file
значение file : /tmp/data.file 
anik@K53:~/dos-01$ ./part2.sh thefile
file задано значение thefile
```

# 3) Написать скрипт, который будет выводить все имена файлов *.c в текущей директории без суффикса “.c”. Для тестирования скрипта создать файлы с расширением “.c” в данной директории. Использовать string operation.

```bash
#!/bin/bash
direct=$PWD
for file in $direct/*
do 
filename=${file%.*c}
echo "файлы без *.с $filename"
done
#вывод:
anik@K53:~/dos-01$ ./part3.sh
файлы без *.с /home/anik/dos-01/hostname.sh
файлы без *.с /home/anik/dos-01/HW15
файлы без *.с /home/anik/dos-01/HW16
файлы без *.с /home/anik/dos-01/HW17
файлы без *.с /home/anik/dos-01/HW18
файлы без *.с /home/anik/dos-01/HW20
файлы без *.с /home/anik/dos-01/ip.sh
файлы без *.с /home/anik/dos-01/Ivanovich lecture15
файлы без *.с /home/anik/dos-01/kernel.sh
файлы без *.с /home/anik/dos-01/LA.sh
файлы без *.с /home/anik/dos-01/lecture15
файлы без *.с /home/anik/dos-01/lecture16
файлы без *.с /home/anik/dos-01/ostype.sh
файлы без *.с /home/anik/dos-01/part2.sh
файлы без *.с /home/anik/dos-01/part3.sh
файлы без *.с /home/anik/dos-01/ram.sh
файлы без *.с /home/anik/dos-01/README.md
файлы без *.с /home/anik/dos-01/test2
файлы без *.с /home/anik/dos-01/test
файлы без *.с /home/anik/dos-01/testfunc.sh
файлы без *.с /home/anik/dos-01/test.sh
файлы без *.с /home/anik/dos-01/uptime.sh
файлы без *.с /home/anik/dos-01/uptime.sh.save
файлы без *.с /home/anik/dos-01/uptime.sh.save.1
файлы без *.с /home/anik/dos-01/user.sh
файлы без *.с /home/anik/dos-01/шпаргалка
```
Попробуем с другим расширением

```bash
#!/bin/bash
direct=$PWD
for file in $direct/*
do 
filename=${file%.*sh}
echo "файлы без *.sh $filename"
done

anik@K53:~/dos-01$ ./part3.sh
файлы без *.sh /home/anik/dos-01/hostname
файлы без *.sh /home/anik/dos-01/HW15
файлы без *.sh /home/anik/dos-01/HW16
файлы без *.sh /home/anik/dos-01/HW17
файлы без *.sh /home/anik/dos-01/HW18
файлы без *.sh /home/anik/dos-01/HW20
файлы без *.sh /home/anik/dos-01/ip
файлы без *.sh /home/anik/dos-01/Ivanovich lecture15
файлы без *.sh /home/anik/dos-01/kernel
файлы без *.sh /home/anik/dos-01/LA
файлы без *.sh /home/anik/dos-01/lecture15
файлы без *.sh /home/anik/dos-01/lecture16
файлы без *.sh /home/anik/dos-01/ostype
файлы без *.sh /home/anik/dos-01/part2
файлы без *.sh /home/anik/dos-01/part3
файлы без *.sh /home/anik/dos-01/ram
файлы без *.sh /home/anik/dos-01/README.md
файлы без *.sh /home/anik/dos-01/test2.c
файлы без *.sh /home/anik/dos-01/test.c
файлы без *.sh /home/anik/dos-01/testfunc
файлы без *.sh /home/anik/dos-01/test
файлы без *.sh /home/anik/dos-01/uptime
файлы без *.sh /home/anik/dos-01/uptime.sh.save
файлы без *.sh /home/anik/dos-01/uptime.sh.save.1
файлы без *.sh /home/anik/dos-01/user
файлы без *.sh /home/anik/dos-01/шпаргалка
anik@K53:~/dos-01$ 
```

# 4) Написать скрипт, который будет считать the sum and average чисел в 3 колонках
Входные данные

The input:
4  10  21
6  20  31

Should print:
sum 10  30  52
ave   5    15  26  

Создал  файл count с набором столбцов как в исходном задании

```bash
#!/bin/bash
awk 'BEGIN{sum=0} {sum+=$1; sum2+=$2; sum3+=$3; sum4=sum/2; sum5=sum2/2; sum6=sum3/2 } END{print "Сумма по столбцам:" sum, sum2, sum3 ," среднее :" sum4, sum5, sum6 }' count
```

Вывод скрипта:
```bash
anik@K53:~/dos-01$ ./part4.sh
Сумма по столбцам:10 30 52

#Добавим значения в исходный файл 
4  10  21
6  20  31
43 12  43
```



# 5) Написать скрипт для добавления нового пользователя в систему с указанием домашнего каталога, окружения и тд. Все данные вводятся с клавиатуры при запуске скрипта. Если пользователь существует, выводить ошибку и сообщение об ошибке.

```bash
#!/bin/bash
echo "Введи имя юзера: "
read xuser
if grep -q "$xuser:" /etc/passwd; then
    printf 'The user %s exists\n' "$xuser"
    echo "есть такой, введи другое имя"
else
    printf 'The user %s does not exist\n' "$xuser"
    echo "Введи директорию (прим./home/anik/user)"; read xdirectory
#    echo "Введи группу (прим. piraty)"; read xgroup
    echo "Введи домашний каталог (прим. /bin/bash) "; read xhomedir
    sudo useradd -d $xdirectory -m -s $xhomedir $xuser
    sleep 5
    echo "Информация о новом пользователе: "
    less /etc/passwd | grep "$xuser"
fi
```
Listing:
```bash
anik@K53:~/dos-01$ ./part5.sh
Введи имя юзера: 
pirat
The user pirat does not exist
Введи директорию (прим./home/anik/user)
/home/anik/pirat
Введи домашний каталог (прим. /bin/bash) 
/bin/bash
Информация о новом пользователе: 
pirat:x:1001:1001::/home/anik/pirat:/bin/bash
```