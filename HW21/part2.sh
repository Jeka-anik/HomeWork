#!/bin/bash 
var=$(ssh rab2@192.168.122.150 'bash -s' < part1.sh) 
bar=$( echo $var | sed 's/,/./')
echo $bar
var1=$(echo "scale=1; $bar*10" | bc)
echo $var1
#echo $var 
if (( $(echo "$var1<7" | bc -l) ))
  then echo "Norm"
  else 
  if (( $(echo "$var1<8" | bc -l) ))
    then echo "Mail send"
    else
      if (( $(echo "$var1 < 9" | bc -l) ))
        then echo "List 10 big file"
        else 
         if (( $(echo "$var1<10" | bc -l) ))
           then echo "Del 5 big file directory /var/log"
           else echo "Ploho"
            fi
        fi
    fi
fi





