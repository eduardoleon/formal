/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.7 Reusable barrier
    3.7.3 Reusable barrier non-solution #2

    vk, 2017
*/

#define THREADS 3    /* value for threads number */
#define N       3    /* value for barrier limit */

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte count=0, mutex=1, turnstile=0    /* turnstile is locked */

proctype Th(byte i) {
    byte temp

rendezvous:
    do
    ::  wait(mutex)
            temp=count
            count=temp+1
        if
        :: count == N ->    /* may be true for one thread only */
            signal(turnstile)
        :: else
        fi
        signal(mutex)

        wait(turnstile)
        signal(turnstile)
        printf("Th(%d): count = %d, turnstile = %d\n",i,count,turnstile)
critical:
        wait(mutex)
            temp=count
            count=temp-1
        if
        :: count == 0 ->    /* may be true for one threads only */
            wait(turnstile)    /* leave turnstile locked */
        :: else
        fi
        signal(mutex)
        break    /* one only iteration */  
    od
}

init {
    byte i

    atomic {
        for (i: 1 .. THREADS) {
            run Th(i)
        }
    }
    _nr_pr == 1 ->
        assert(turnstile == 0)
        printf("turnstile = %d\n",turnstile)
}
