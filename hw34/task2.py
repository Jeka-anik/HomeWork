coffe7=int(input("Введи количество чашек: "))
age=int(input("Введи возраст свой, о мой юный кофеиновый заложник: "))
win=coffe7/7 
if win < 1 and age < 18:
    print("Ты еще не заслужил бесплатный кофе. Да и пить кофе тебе еще рано") 
elif win > 1 and age < 18:
    print("рано тебе так много пить")
elif win < 1 and age > 18:
    print("у тебя все впереди")
else:
    x=coffe7//7
    print("Ты заслужил кофе, тебе положено: ",x, "чашек бодрящего напитка")
