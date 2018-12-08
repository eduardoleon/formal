/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.6 Barrier
    3.6.4 Barrier solution
*/

#define N 3

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte count=0, mutex=1, barrier=0 /* barrier is locked */

proctype P(byte i) {
    do
    ::  wait(mutex)
            count++
        signal(mutex)

        if
        :: count == N ->
                         signal(barrier)
        :: else
        fi

        wait(barrier)    /* turnstile pattern */
        signal(barrier)

        break    /* one only iteration */
    od
}

init {
    byte i

    atomic {
        for (i: 1 .. N) {
            run P(i)
        }
    }
    _nr_pr == 1 ->
                   assert(barrier == 0) /* find all scenarios */
}
