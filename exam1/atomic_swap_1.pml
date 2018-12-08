#define lock(sem)      atomic { sem > 0; sem-- }
#define unlock(sem)    sem++

#define N 8

byte cell[N] = 0
byte mutex[N]=1


proctype AtomicSwap(byte f, s) {
    byte item[2]

    lock(mutex[f])
    item[0] = cell[f]
    if
    :: item[0] != 0 -> lock(mutex[s])
                       item[1] = cell[s]
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
    byte i

    cell[0]=8; cell[2]=2; cell[4]=4; cell[6]=6
    cell[1]=1; cell[3]=3; cell[5]=5; cell[7]=7

    printf("cell:")
    for (i in cell) {
        printf("%d",cell[i])
    }
    printf("\n")

    i = 0
    do
    :: i == 8 -> break
    :: else   -> run AtomicSwap(i,i+1); i = i+2
    od
    _nr_pr == 1
    
    printf("cell:")
    for (i in cell) {
        printf("%d",cell[i])
    }
    printf("\n")
}
