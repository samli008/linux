## install and use screen
```
yum -y install screen
screen -S xxx             #create new session
screen -ls                #view session
screen -x xxx             #login exist session
ctr + a + d               #exit and keep session
exit                      #exit and turn off session
```
## screen with serial console
```
dmesg |grep tty
screen /dev/ttyS0 9600,cs8
ctr + a +d  #exit serial console
```
