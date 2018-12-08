/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.7 Reusable barrier
    3.7.1 Reusable barrier non-solution #1
*/

#define N 3

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte count=0, mutex=1, turnstile=0 /* turnstile is locked */

proctype P(byte i) {
    do
    ::  wait(mutex)
            count++
        signal(mutex)

        if
        :: count == N ->
                         signal(turnstile)
        :: else
        fi

        wait(turnstile)
        signal(turnstile)

        /* critical point */

        wait(mutex)
            count--
        signal(mutex)

        if
        :: count == 0 ->
                         wait(turnstile)
        :: else
        fi

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
                   assert(turnstile == 0) /* must be locked */
}
