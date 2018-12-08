def divMod(x,y):
    assert y>0, "The divisor is 0"
    r,q= x,0
    while r>y:
        r,q= r-y,q+1
    assert x==y*q+r, "Function error"
    return q,r

q,r= divmod(22,7)
print()
print("divmod (builtin function): 22 = 7 *",q,'+',r)
print()

for i in range(5):
    q,r= divMod(100+i,7)
    print("%d = %d*%d + %d" % (100+i,7,q,r))
