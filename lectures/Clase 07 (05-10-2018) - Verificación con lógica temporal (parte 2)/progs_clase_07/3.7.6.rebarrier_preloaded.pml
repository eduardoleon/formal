/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.7 Reusable barrier
    3.7.6 Preloaded turnstile

    vk, 2017
*/

#define THREADS 3    /* value for threads number */
#define N       3    /* value for barrier limit */

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++
#define signalN(sem,NN) for (j: 1 .. NN) { sem++ } /* no atomic */

byte count=0, mutex=1, turnstile=0, turnstile2=0
byte loop[THREADS+1]=1
bool sameloop=true

proctype Th(byte i) {
    byte temp, j

rendezvous:
    do
    ::  wait(mutex)
            temp=count
            count=temp+1
        if
        :: count == N ->
            signalN(turnstile,N)   /* unlock the first */
        :: else
        fi
        signal(mutex)

        wait(turnstile)         /* first turnstile */
        printf("Th(%d): loop %d\n",i,loop[i])

critical:
        atomic {
            for (j: 1 .. N-1) {
                sameloop = sameloop && (loop[j] == loop[j+1])
            }
            assert(sameloop)
        }

        wait(mutex)
            temp=count
            count=temp-1
        if
        :: count == 0 ->
            signalN(turnstile2,N) /* unlock the second */
        :: else
        fi
        signal(mutex)

        wait(turnstile2)        /* second turnstile */
        if
        :: loop[i] == 3 ->
            break
        :: else ->
            loop[i]++
        fi
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
        assert(turnstile2 == 0)
}
