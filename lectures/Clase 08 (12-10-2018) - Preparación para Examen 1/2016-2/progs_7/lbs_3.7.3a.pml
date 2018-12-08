/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.7 Reusable barrier
    3.7.3 Reusable barrier non-solution #2
*/

#define N 3

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte count=0, mutex=1, turnstile=0 /* turnstile is locked */

proctype P(byte i) {
    do
    ::  wait(mutex)
            count++
            if
            :: count == N ->
                             signal(turnstile) /* the last opens turnstile */
            :: else
            fi
        signal(mutex)

        wait(turnstile)
        signal(turnstile)

        /* critical point */

        wait(mutex)
            count--
            if
            :: count == 0 ->
                             wait(turnstile) /* the last closes turnstile */
            :: else
            fi
        signal(mutex)
    od
}

init {
    byte i

    atomic {
        for (i: 1 .. N) {
            run P(i)
        }
    }
}
