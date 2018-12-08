def divMod(x,y):
    assert x>=0 and y>0, "Wrong input"  # precondition
    r,q= x,0
    while r>=y:
        assert r>=0 and y>0 and y<=r and x==y*q+r, "Invariant error"
        r,q= r-y,q+1
        assert r>=0 and y>0 and x==y*q+r, "Invariant error"
    assert x==y*q+r and 0<=r and r<y, "Function error"   # postcondition
    return q,r

for i in range(7):
    q,r= divMod(100+i,7)
    print("%d = %d*%d + %d" % (100+i,7,q,r))
