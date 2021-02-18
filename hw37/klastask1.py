# class Name:
#     def __init__(self,first_name,last_name):
#         self.first_name = first_name.capitalize()
#         self.last_name = last_name.capitalize()
#         self.full_name = self.first_name + ' ' + self.last_name
#         self.initials = self.first_name[0] + ' ' + self.last_name[0]

# n = Name ('Sergey', 'KiykO')
# print(n.first_name)
# print(n.last_name)
# print(n.full_name)
# print(n.initials)

class Hero():
    """"Class for lessen"""
    def __init__(self, name, level, race):
        """Initiate our hero"""
        self.name = name
        self.level =  level
        self.race =  race
        self.healthe = 100

    def show_hero(self):
        """Print all parameters of this Hero"""
        discription = (self.name + " level is: " + str(self.level) + " Rase is:" + self.race + " Health is: " + str(self.healthe)).title()
        print(discription)


    def level_up(self):
        """Level up"""
        self.level += 1

    def move(self):
        """start moving hero"""
        print("Hero " + self.name + "start moving...")
    


myhero1 = Hero("vURDALAK", 5, "Orc")
myhero2 = Hero("Alex", 1, "Human")


myhero1.show_hero()
myhero2.move()
myhero1.level_up()
myhero2.level_up()
myhero2.show_hero()

