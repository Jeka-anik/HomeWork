
stroka = input("Input strochku: ")
print("4to ti nabral ", stroka)
glasnaya="a"
countA=stroka.count(glasnaya)
print("Kol-vo *A* : ", countA)
glasnayi="i"
countI=stroka.count(glasnayi) 
print("Kol-vo *I* : ", countI)
glasnaye="e"
countE=stroka.count(glasnaye) 
print("Kol-vo *E* : ", countE)
glasnayo="o"
countO=stroka.count(glasnayo) 
print("Kol-vo *O* : ", countO)
glasnayu="u"
countU=stroka.count(glasnayu)
print("Kol-vo *U* : ", countU)
glasnayy="y"
countY=stroka.count(glasnayy)
print("Kol-vo *Y* : ", countY)
print("Kol-vo *A* i *I* i *E* i *O* i *U* i *Y*: ", countI+countA+countE+countO+countU+countY)
