def optimal(ts):
    n = len(ts)
    d = 2*ts[1] - ts[0]
    t = (n-3)*ts[0] + sum(ts)
    o = t
    for i in range(n // 2):
        t += d - ts[-2*(i+1)]
        o = min(o,t)
    return o
