import math
from math import hypot

x1=int(input("Введи x первой точки:"))
y1=int(input("Введи y первой точки:"))
x2=int(input("Введи x второй точки:"))
y2=int(input("Введи y второй точки:"))

#есть два способа нахождения расстояния между двумя точками
dist=round(math.sqrt((x2-x1)**2+(y2-y1)**2),3)
print('Способ первый. Через формулу.\nРасстонияе между точками будет равно:', dist)
#второй способ. подключая from math import hypot
dist2=round(math.hypot(x2-x1,y2-y1),3)
print("Второй способ. Используя math.hypot().\nРасстояие между точками будет равно:", dist2)
