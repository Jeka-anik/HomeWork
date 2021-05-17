def func(stroka):
   x='//'
   y=stroka.rsplit(x)
   return y




if __name__ == '__main__':
    print(func('utcfv//dfwgd//sdgdgs/sdgsfg//sdgsdg'))


    assert list(func('vghn')) == ['vghn']
    assert list(func('fvgh//bh//v')) == ['fvgh', 'bh', 'v']
