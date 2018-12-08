#define N 4

int delay[N] = {1, 20, 21, 22}

init {
    int diff = 2 * delay[1] - delay[0]
    int temp = (N-3) * delay[0]
    int i
    for (i : 0 .. N-1) {
        temp = temp + delay[i]
    }
    
    int optimal = temp
    for (i : 1 .. N / 2) {
        temp = temp + diff - delay[N - 2*i]
        if
        :: optimal > temp -> optimal = temp
        :: else           -> skip
        fi
    }
    
    printf("%d\n", optimal)
}
