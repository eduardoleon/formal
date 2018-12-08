#define lock(sem)      atomic { sem > 0; sem-- }
#define unlock(sem)    sem++

int time
int t[2], a[2]
byte mutex

active proctype A() {
    byte cond1

    time = time + 1
    time = time + 2
    t[0] = 3
    a[0] = 2
    do
    :: a[0] == 0 -> break
    :: else ->  a[0] = a[0] - 1
                do
                :: t[0] <= t[1] -> break
                od
                if
                :: cond1 != 0 ->
                                lock(mutex)
                                time = time + 1
                                time = time + 2
                                t[0] = t[0] + 3
                                unlock(mutex)
                :: cond1 == 0 ->
                                time = time + 1
                fi
    od
    t[0] = 1000
}
