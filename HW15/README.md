# 1) Ваша задача - создать проект с кодом, добавить туда файлы со след. расширениями:

 * all files with exe extension
 * all files with o extension
 * all files with jar extension
 * the whole libraries directory

 Закоммитить код, исключая данные расширения файлов

anik@K53:~/dos-01/Lecture15$ vi .gitignore
*.exe
*.o
*.jar
*.lib

```bash
anik@K53:~/dos-01/lecture15$ touch 1.exe
anik@K53:~/dos-01/lecture15$ touch 3.jar
anik@K53:~/dos-01/lecture15$ touch 2.o
anik@K53:~/dos-01/lecture15$ touch 4.lib
anik@K53:~/dos-01/lecture15$ touch 5.txt
anik@K53:~/dos-01/lecture15$ touch 6.txt

anik@K53:~/dos-01/Lecture15$ git status
На ветке DZ
Ваша ветка обновлена в соответствии с «origin/DZ».


как видим, будут проигнорены файлы, с расширением которые указаны в gitignore 

anik@K53:~/dos-01/lecture15$ git add
Ничего не указано, ничего не добавлено.
Возможно, вы имели в виду «git add .»?
anik@K53:~/dos-01/lecture15$ git add .
anik@K53:~/dos-01/lecture15$ git commit -m "ver1.0"
[DZ e775ff4] ver1.0
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 lecture15/5.txt
 create mode 100644 lecture15/6.txt
```


# 2) Изменить регистр букв в файле

Вы закоммитили File.txt, но осознали, что он должен быть file.txt
Изменить это.

```bash
anik@K53:~/dos-01/lecture15$ touch File.txt
anik@K53:~/dos-01/lecture15$ git add .
anik@K53:~/dos-01/lecture15$ git commit -m "Fike"
[DZ d0beb8e] Fike
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 lecture15/File.txt
anik@K53:~/dos-01/lecture15$ mv File.txt file.txt
anik@K53:~/dos-01/lecture15$ git add file.txt
anik@K53:~/dos-01/lecture15$ git commit --amend --no-edit
[DZ 6d16922] Fike
 Date: Fri Nov 13 13:14:01 2020 +0300
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 lecture15/File.txt
 create mode 100644 lecture15/file.txt
anik@K53:~/dos-01/lecture15$ 
```

# 3) Найти коммит, который был утерян

Вы создали коммит с важным куском работы. Затем решили пофиксать что-то в последнем коммитет и сделали amend. 
Далее вы осознали, что закоммитили не те изменения и нужно вернуться к первой версии коммита, который вы заамендили.

Однако в истории нет предыдущей версии - вы отредактировали коммит, используя git commit --amend
Ваша цель - найти первую версию фикса в репозитории.

создам файл , сделаю несколько коммитов 
лог 

```bash
anik@K53:~/dos-01/lecture15$ git log
commit a98e6c990ce219c2b90ac7cc1ce1a7f48a4f86ec (HEAD -> DZ, origin/DZ)
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Fri Nov 13 13:26:49 2020 +0300

    ver1.3

commit dd0b394cc544d9f7df9ebdbbc3085f9969558a35
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Fri Nov 13 13:25:19 2020 +0300

    ver1.2

commit f5385e766ef1a91ada0d4fbb8d6912b4a24b9f7d
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Fri Nov 13 13:24:20 2020 +0300

    ver1.0


текст файла file.txt

"просто текст и какая то работа. первая редакция 
еще немного текста и какой то работы. Вторая редакция 
а теперь важный кусок работы . Третья редакция"


перед amend 

просто текст и какая то работа. первая редакция 
еще немного текста и какой то работы. Вторая редакция 
а теперь важный кусок работы . Третья редакция
добавляю не те измения, после которых буду делать аменд

anik@K53:~/dos-01/lecture15$ git add file.txt
anik@K53:~/dos-01/lecture15$ git commit --amend
[DZ 54c5599] ver1.3
 Date: Fri Nov 13 13:26:49 2020 +0300
 1 file changed, 2 insertions(+)

 anik@K53:~/dos-01$ git pull
Автослияние lecture15/file.txt
КОНФЛИКТ (содержимое): Конфликт слияния в lecture15/file.txt
Не удалось провести автоматическое слияние; исправьте конфликты и сделайте коммит результата.
```
а теперь вернем первую версию фикса в репозитории
```bash
git log

наш коммит 
commit 54c5599983278d9aa5f57dcb7b13ad3b6ba58024
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Fri Nov 13 13:26:49 2020 +0300

    ver1.3

    anik@K53:~/dos-01$ git revert 54c5599983278d9aa5f57dcb7b13ad3b6ba58024
Автослияние lecture15/file.txt
КОНФЛИКТ (содержимое): Конфликт слияния в lecture15/file.txt
error: не удалось обратить изменения коммита 54c5599… ver1.3
подсказка: после разрешения конфликтов, пометьте исправленные пути
подсказка: с помощью «git add <пути>» или «git rm <пути>»
подсказка: и сделайте коммит с помощью «git commit»
```

откатил кароч) 


# 4) Закоммитить часть работы

Вы работаете на фиксом долгое время и сделали огромную работу. Вы хотите, чтобы ваша работа была закомичена двумя коммитами.

Но к сожалению, у вас все изменения в одном файле и вы не можете разбить на два файла (разделить).


сделал файл с таким текстом

"часть 1
просто текст и какая то работа. первая редакция 
еще немного текста и какой то работы. Вторая редакция 
часть 2
и добавим еще текста что бы коммитить по частям "

будем использовать git add -p 
выбрал ключ е , для мануального редактирования 

результат в директории /lectore15/file.txt 

Manual hunk edit mode -- see bottom for a quick guide.
@@ -1,2 +1,5 @@
-часть 1
-просто текст и какая то работа. первая редакция 
-еще немного текста и какой то работы. Вторая редакция 
+часть 2
+и добавим еще текста что бы коммитить по частям 