# 1) Lecture20 - task1: упростить скрипт, сделать проверку в цикле




# 2) Баш скрипт, который проверяет дисковое пространство на удаленных машинах
  ##  1. Если больше 70 процентов - шлет на почту оповещение
  ##  2. Если больше 80 процентов - шлет список самых больших 10 файлов по размеру
  ##  3. Если больше 90 процентов - удаляет файлы из var/log - топ 5

Для выполнения задачи, мне нужны два скрипта. Начнем с того, что поменьше 
```bash
#!/bin/bash
df -h | grep "/dev/vda5" | awk '{print $3/$2}' 
```
На него ссылаться будем, из основного.
Второй скрипт
```bash
#!/bin/bash 
FROM=jeka1993g@mail.ru
MAILTO=jeka1993g@mail.ru 
NAME=ALERT
SMTPSERVER=smtp.mail.ru
SMTPLOGIN=jeka1993g@mail.ru 
SMTPPASS=199514qaz
var=$(ssh rab2@192.168.122.150 'bash -s' < part1.sh) 
bar=$( echo $var | sed 's/,/./')
echo $bar
var1=$(echo "scale=1; $bar*10" | bc)
echo $var1
BODY="Осталось $var1 . Надо чистить"
if (( $(echo "$var1<7" | bc -l) ))
  then echo "Norm"
  else 
  if (( $(echo "$var1<8" | bc -l) ))
    then echo "Mail send for $FROM"
         /usr/bin/sendEmail -f $FROM -t $MAILTO -o message-charset=utf-8  -u $NAME -m $BODY -s $SMTPSERVER -o tls=yes -xu $SMTPLOGIN -xp $SMTPPASS
    else
      if (( $(echo "$var1 < 9" | bc -l) ))
        then echo "List 10 big file"
             ls -1S /var/log | head -n10
        else 
         if (( $(echo "$var1<10" | bc -l) ))
           then echo "Del 5 big file directory /var/log"
                ls -1S /var/log | head -n5 -exec rm -rf {} \;
           else echo "Ploho"
            fi
        fi
    fi
fi
```

3) Bash trap


4) Обработка ошибок
5) Библиотека
6) Как вызывать функцию из командной строки!
7) Expect
8) Typeset внутри функции  и local 
9) Экранирование
10)Работа с аргументами в функции