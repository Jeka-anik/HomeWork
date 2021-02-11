def my_func(a,b):
    if a % 2 == 0:
        if b % 2 == 0:
            z=print("Оба числа четные")
        else:
            z=print("Одно число не четное. Их разность будет", a-b)
    else:
        if b % 2 == 0:
            z=print("Одно число не четное. Их разность будет", a-b)
        else:
            z=print("Оба числа нечетные. Как жаль")

    return z


x=int(input("Число Х: "))
y=int(input("Число Y: "))
my_func(x,y)
 