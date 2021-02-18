class Calc():
    """primitive Calculator"""
    def __init__(self, x, y):
        """initials two number"""
        self.x = x
        self.y = y

    def summa(self):
        """summa two number"""
        suma = (self.x + self.y)
        print("Summa number: ", suma)
    
    def raz(self):
        """raznost two number"""
        razn = (x - y)
        print("raznost number: ", razn)

    def proiz(self):
        """proizvedenie two number"""
        pr = (x * y)
        print("proivedeniy number: ", pr)

    def dzel(self):
        """delenie two number"""
        delen = (x / y)
        print("Delenie two number: ", delen)

################Body Code###############

x = int(input("Input a: "))
y = int(input("Input b: "))

"""Пример"""
calc1 = Calc(x, y)

calc1.dzel()
calc1.proiz()
calc1.raz()
calc1.summa()