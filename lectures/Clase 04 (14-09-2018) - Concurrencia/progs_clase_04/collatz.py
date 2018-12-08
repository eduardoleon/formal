import sys,threading

def odd():
    global n
    while True:
        if n==1: break
        if n& 1:
            n= 3*n+1
            print(n,end=' ')

def even():
    global n
    while True:
        if n==1: break
        if not n& 1:
            n>>= 1
            print(n,end=' ')

try:
    n= int(sys.argv[1])
except IndexError:
    print("Missed o wrong input")
    sys.exit(1)

assert n>0, "Must be positive integer"
print(n,end=' ')
t1= threading.Thread(target=odd)
t2= threading.Thread(target=even)
t1.start(), t2.start()
t1.join(), t2.join()
print()
