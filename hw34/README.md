# Пользователь вводит строку из букв в нижнем регистре. Нужно посчитать, сколько в этой строке английских гласных букв. Корректность ввода не проверять.
6 букв могут обозначать гласные звуки (монофтонги и дифтонги, самостоятельно или в составе диграфов): «A», «E», «I», «O», «U», «Y»
Код программы в файле _task1.py_
Вывод программы: 
```py
Input strochku: aaaaiiiiiyyeennxjbcnoooajaslkc
4to ti nabral  aaaaiiiiiyyeennxjbcnoooajaslkc
Kol-vo *A* :  6
Kol-vo *I* :  5
Kol-vo *E* :  2
Kol-vo *O* :  3
Kol-vo *U* :  0
Kol-vo *Y* :  2
Kol-vo *A* i *I* i *E* i *O* i *U* i *Y*:  18
```



# Клиент покупает кофе в кафе. За каждые 6 чашек, 1 чашка даётся в качестве бонуса. Задача: запросить у пользователя кол-во чашек на покупку, вычислить полагающееся кол-во бонусных чашек кофе и вывести это число на консоль. В функцию можно передать строку, которая будет выведена на экран для общения с пользователем, например: age = input('Введите ваш возраст') 
```bash
Для выполнения этого задания, использовать файл task2.py
Вывод программы:
anik@K53:~/HomeWork$ /usr/bin/python3 /home/anik/HomeWork/hw34/task2.py
Введи количество чашек: 56
Введи возраст свой, о мой юный кофеиновый заложник: 27
Ты заслужил кофе, тебе положено:  8 чашек бодрящего напитка
anik@K53:~/HomeWork$ /usr/bin/python3 /home/anik/HomeWork/hw34/task2.py
Введи количество чашек: 4
Введи возраст свой, о мой юный кофеиновый заложник: 10
Ты еще не заслужил бесплатный кофе. Да и пить кофе тебе еще рано
anik@K53:~/HomeWork$ /usr/bin/python3 /home/anik/HomeWork/hw34/task2.py
Введи количество чашек: 20
Введи возраст свой, о мой юный кофеиновый заложник: 13
рано тебе так много пить
anik@K53:~/HomeWork$ /usr/bin/python3 /home/anik/HomeWork/hw34/task2.py
Введи количество чашек: 5
Введи возраст свой, о мой юный кофеиновый заложник: 22
у тебя все впереди
```


# Запросить у пользователя координаты x и y двух точек на плоскости. Посчитать расстояние между заданными точками и вывести результат на консоль с точностью до трёх знаков после запятой (плавающей точки). Примечание: у каждой точки есть две координаты: x и y. Формулу в интернете можно посмотреть.
Код программы : файл _task3.py_
Вывод программы:
```
Введи x первой точки:2
Введи y первой точки:2
Введи x второй точки:6
Введи y второй точки:6
Способ первый. Через формулу.
Расстонияе между точками будет равно: 5.657
Второй способ. Используя math.hypot().
Расстояие между точками будет равно: 5.657
```
