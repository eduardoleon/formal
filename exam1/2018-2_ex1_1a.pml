#define lock(sem)      atomic { sem > 0; sem-- }
#define unlock(sem)    sem++

int time
int t[2], a[2]
byte mutex = 1

active proctype A() {
    time = time + 1
    time = time + 2
    t[0] = 3
    a[0] = 2
    do
    :: a[0] == 0 -> break
    :: else ->  a[0] = a[0] - 1
                if
                :: t[0] <= t[1] -> break
                :: else         -> skip
                fi
                if
                :: true ->
                           lock(mutex)
                           time = time + 1
                           time = time + 2
                           t[0] = t[0] + 3
                           unlock(mutex)
                :: true ->
                           time = time + 1
                fi
    od
    t[0] = 1000
}
