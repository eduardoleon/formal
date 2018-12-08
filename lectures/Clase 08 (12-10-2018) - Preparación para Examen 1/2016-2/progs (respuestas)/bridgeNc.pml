#define N 4

byte a[N]=0, t=0
bool sorted=true

proctype Bridge() {
    byte i

    for (i: 2 .. N/2) {
        t=a[1]
        printf("(0,1) -->    , t = %d\n", t)
        t=t+a[0]
        printf("      <-- (0), t = %d\n", t)
        t=t+a[2*i-1]
        printf("(%d,%d) -->    , t = %d\n", a[2*i-2],a[2*i-1],t)
        t=t+a[1]
        printf("      <-- (1), t = %d\n", t)
    }
    t=t+a[1]
    printf("(0,1) -->    , t = %d\n", t)
    assert(t>=83)
}

init {
    byte i

    a[0]=1; a[1]=20; a[2]=21; a[3]=22
    for (i: 0 .. N-2) {
        sorted=sorted && (a[i]<=a[i+1])
    }
    assert(sorted)
    assert(N%2==0 && N>3)
    run Bridge()
}
