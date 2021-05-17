file=open('./test.txt')
print(file.read())
file.seek(0)
print(file.read())
file.seek(0)
lines=file.readlines()
print(type(lines))
print(lines)
len(lines)

file.close()
print(file.closed)

with open ('test.txt', mode='r+') as my_file:
    my_date=my_file.read()
    my_file.write('\ndos01 lolololo')
    my_file.seek(0)
    print(my_file.read())
print(my_file.closed)

