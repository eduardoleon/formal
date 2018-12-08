def divMod(x,y):
    assert x>=0 and y>0, "Wrong input"
    r,q= x,0
    while r>=y:
        r,q= r-y,q+1
    assert x==y*q+r and r<y, "Function error"
    return q,r

for i in range(7):
    q,r= divMod(100+i,7)
    print("%d = %d*%d + %d" % (100+i,7,q,r))
