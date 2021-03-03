# # Создать класс Students, который принимает в качестве аргументов следующие атрибуты
#  (имя, фамилия, класс, успеваемость)
# В класс мы передаем данные в виде строки(Имя:Фамилия:Класс:успеваемость)
#  Пример:
# student = Students(‘Sergey:Kiyko:11:10’)

class Students():
    """ Initiates class Students"""
    def __init__(self, name, lastname, klass, rating):
        """initials parametr of students"""
        self.name = name
        self.lastname = lastname
        self.klass = klass
        self.rating = rating

 

    def full(self):
        x = self.name + ':' + self.lastname +':'+ str(self.klass) +':'+str(self.rating)
        print(x)


student = Students ( "Sergey", "Kiyko", 11, 10)

student.full()

