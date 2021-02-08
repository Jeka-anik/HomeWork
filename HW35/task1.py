str1=input("first stroka: ")
str2=input("second stroka:  ")
print(list(str1))
print(list(str2))
for i in str1:
    for j in str2:
        if i == j:
            print( i,"первая строка-", str1.index(i)+1,",вторая строка-",str2.index(i)+1)
            break

