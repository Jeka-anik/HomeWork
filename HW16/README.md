# Инциализировать репу, сделать 10 коммитов, слиять коммиты в 2 (2 способа) #

```bash
anik@K53:~/dos-01$ mkdir lecture16
anik@K53:~/dos-01$ cd lecture16
anik@K53:~/dos-01/lecture16$ git init
Инициализирован пустой репозиторий Git в /home/anik/dos-01/lecture16/.git/
anik@K53:~/dos-01/lecture16$ 
anik@K53:~/dos-01/lecture16$ touch best.txt
anik@K53:~/dos-01/lecture16$ git log
commit efddce45e65926b3c1ef0fe68a1306c7e49650c6 (HEAD -> master)
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:39:27 2020 +0300

    commit 10

commit ffe4d564571de5b7f5dec4f94e9fe3d0d6a2bec3
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:39:02 2020 +0300

    commit 9

commit e8726f9c58f9ce80214be02724703660ca664346
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:38:19 2020 +0300

    commit 8

commit 50310294a6b89917304b3d9a0291ecb4e83a91de
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:37:37 2020 +0300

    commit 7

commit f79394accec6e5e1c43e3ac710ab2193c9889aeb
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:37:04 2020 +0300

    commit 6

commit e94016cc0c54d204efd38b603390c922b6530081
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:35:50 2020 +0300

    commit 5

commit b743f26d936c114a8f32537a8ae61c7bf8ecc6ae
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:35:10 2020 +0300

    commit 3

commit e0580a63450ef1730652355658969b8c21fc08ed
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:34:33 2020 +0300

    commit 4

commit 5f60324c7552ea34cf3824fc6e9f495aa2292d6b
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:32:49 2020 +0300

    commit 2

commit 1ade25725c017eabec623369992cc40b42409209
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:31:57 2020 +0300

    commit 1
```
Cделал 10 коммитов одного файла 
    файл best.txt
    буду объединять по несколько коммитов для каждого способа 
первый способ:

```bash
anik@K53:~/dos-01/lecture16$ git rebase -i HEAD~4
[отделённый HEAD 261c5af] commit 7
 Date: Sat Nov 14 16:37:37 2020 +0300
 1 file changed, 4 insertions(+)
Successfully rebased and updated refs/heads/master.
anik@K53:~/dos-01/lecture16$ git log
commit 261c5af9908b0fa759b358e0a44646f99729fb86 (HEAD -> master)
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:37:37 2020 +0300

    commit 7
    
    commit 8
    
    commit 9
    
    commit 10

commit f79394accec6e5e1c43e3ac710ab2193c9889aeb
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:37:04 2020 +0300

    commit 6
```

    менял pick на squash

    второй способ 
```bash
anik@K53:~/dos-01/lecture16$ git reset --soft HEAD~4
anik@K53:~/dos-01/lecture16$ git commit --amend
[master 8e160c5] commit 7-3
 Date: Sat Nov 14 16:34:33 2020 +0300
 1 file changed, 8 insertions(+)
anik@K53:~/dos-01/lecture16$ git log
commit 8e160c5d65d74c300c1dd88f73d5cc49640cffb1 (HEAD -> master)
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:34:33 2020 +0300

    commit 7-3

commit 5f60324c7552ea34cf3824fc6e9f495aa2292d6b
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:32:49 2020 +0300

    commit 2

commit 1ade25725c017eabec623369992cc40b42409209
Author: Evgeniy <anik.evgeniy@gmail.com>
Date:   Sat Nov 14 16:31:57 2020 +0300

    commit 1
anik@K53:~/dos-01/lecture16$ 
```

# 2) Привести примеры отличия git fetch vs git pull. #

При использовании pull, git пытается сделать всё за вас.
 Он сливает любые внесённые коммиты в ветку, 
 в которой вы сейчас работаете. Команда pull автоматически 
 сливает коммиты, не давая вам сначала просмотреть 
 их. Если вы не пристально следите за ветками, 
 выполнение этой команды может привести к частым конфликтам.

При использовании fetch, git собирает все коммиты из целевой 
ветки, которых нет в текущей ветке, и сохраняет их в локальном 
репозитории. Однако он не сливает их в текущую ветку. Это
 особенно полезно, если вам нужно постоянно обновлять свой 
 репозиторий, но вы работаете над функциональностью, неправильная 
 реализация которой может негативно сказаться на проекте в целом.
  Чтобы слить коммиты в основную ветвь, нужно использовать merge.

Грубо говоря, по дефолту git pull — это шоткод для последовательности 
двух команд: git fetch (получение изменений с сервера) и git merge 
(сливание в локальную копию)

# 3) Посмотреть команды rebase, рассказать отличия от merge. #
 Привести примеры на практике.

 Merge - слияние 
 Rebase - перемещение 
 
 создадим тестовую ветку для merge
 в ветке мастер 
 файл file.txt
 текст
 "Очень важный текст"

 ветка testing
 файл  file.txt
 текст
 "Очень важный текст.
Это какие-то изменения для ветки testing"

делаю merge 
git merge testing 

Очень важный текст.
<<<<<<< HEAD
=======
Это какие-то изменения для ветки testing
>>>>>>> testing

вывод:
делает слияние коммитов.

провернем подобное но для rebase 
создадим ветку testing2
файл file.txt
"Очень важный текст.
а это текст для rebase . тоже очень важный"
git rebase master

вывод 

Очень важный текст.
<<<<<<< HEAD
<<<<<<< HEAD
=======
Это какие-то изменения для ветки testing
>>>>>>> testing
=======
а это текст для rebase . тоже очень важный
>>>>>>> comfortesting2
~                         

перебазирование делает историю коммитов чище