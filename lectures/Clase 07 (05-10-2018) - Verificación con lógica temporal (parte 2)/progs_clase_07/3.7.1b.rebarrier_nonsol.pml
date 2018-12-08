/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.7 Reusable barrier
    3.7.1 Reusable barrier non-solution

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
        signal(mutex)
        if
        :: count == N ->
            signal(turnstile)
        :: else
        fi
        wait(turnstile)
        printf("Th(%d): count = %d\n",i,count)
        signal(turnstile)
critical:
        wait(mutex)
            temp=count
            count=temp-1
        signal(mutex)
        if
        :: count == 0 ->
            wait(turnstile)    /* leave turnstile locked */
        :: else
        fi
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
