import sys,threading

try:
    N = int(sys.argv[1])
except IndexError:
    print("You must supply iterations number")
    sys.exit(1)

count = 0

def incr():
    global count
    for i in range(N):
        count += 1

t1 = threading.Thread(target=incr)
t2 = threading.Thread(target=incr)
t1.start(), t2.start()
t1.join(), t2.join()
print("count =", count)

