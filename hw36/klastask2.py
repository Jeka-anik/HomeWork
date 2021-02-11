def name_of_function(name,count):

    for _ in range(count):
        print('Hellp', name)
#    return 

print(name_of_function('Sergey', 5))

###############################
test=input("Enter name: ")
if test == 'Serg':
    def func(a,b):
        return a+b

print(func(10,20))

####################################

def my_func(a,b):
    def summa(x,y):
        return x+y
    return summa(a,b)

print(my_func(40,10))

##################################

def dict_func(**kwargs):
    for key, value in kwargs.items():
        print(key, " : ", value)



dict_func(name="sergey", age=15, city='Minsk')

########################################

def f(x,y,z):
    print(x,y,z)

a = list('ST')
print(a)

f(*a, 'M')

#################################


""" def empty (param):
    return expression
     """


sum= lambda a,b : (a+b, a*b)
print(sum(3,5))

def new5(x):
    return lambda y: y+x

test=new5(10)
print(new5(10))


###############################

def generetor():
    yield 1
    yield 2
    yield 3

for n in generetor():
    print(n, " ")