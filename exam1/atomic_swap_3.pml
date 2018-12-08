#define lock(sem)      atomic { sem > 0; sem-- }
#define unlock(sem)    sem++

#define print    printf("cell:"); \
                 for (i in cell) { \
                     printf("%d",cell[i]) \
                 }; \
                 printf("\n")

#define N 4

byte cell[N] = 0
byte mutex[N]=1

proctype AtomicSwap(byte f, s) {
    byte item[2]

    lock(mutex[f])
    item[0] = cell[f]; cell[f] = 0
    if
    :: item[0] != 0 -> lock(mutex[s])
                       item[1] = cell[s]; cell[s] = 0
                       if
                       :: item[1] != 0 ->
                                          cell[s] = item[0]
                                          cell[f] = item[1]
                                          unlock(mutex[s])
                                          unlock(mutex[f])
                       :: else -> skip
                       fi
    :: else -> skip
    fi
}

init {
    byte i,j,k,l

    do
    ::
        if :: cell[0]=8 :: cell[0]=0 fi; if :: cell[2]=2 :: cell[2]=0 fi
        if :: cell[1]=1 :: cell[1]=0 fi; if :: cell[3]=3 :: cell[3]=0 fi
        select (i : 0 .. 3)
        do
        :: select (j : 0 .. 3); if :: j != i -> break :: else -> skip fi
        od
        select (k : 0 .. 3)
        do
        :: select (l : 0 .. 3); if :: l != k -> break :: else -> skip fi
        od
        printf("i=%d, j=%d; k=%d, l=%d:", i,j,k,l)
        atomic {
            run AtomicSwap(i,j); run AtomicSwap(k,l)
        }
        _nr_pr == 1
    od
}
