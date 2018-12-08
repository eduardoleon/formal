/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.6 Barrier
    3.6.2 Barrier non-solution
*/

#define N 3

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte count=0, mutex=1, barrier=0

proctype P() {
    do
    ::  wait(mutex)
            count++
        signal(mutex)
        if
        :: count == N ->
                         signal(barrier)
        :: else
        fi
        wait(barrier)           
    od
}

init {
    byte i

    atomic {
        for (i: 1 .. N) {
            run P()
        }
    }
}
