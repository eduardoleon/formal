/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.7 Reusable barrier
    3.7.7 Barrier objects

    vk, 2017
*/

#include "Semaphore.h"
#include "Barrier.h"

#define THREADS 3    /* value for threads number */
#define N       3    /* value for barrier limit */

Semaphore mutex=1
Barrier   barrier

byte loop[THREADS+1]=1
unsigned group : 31 = 0

proctype Th(byte i) {
    do
    ::
        printf("Th(%d): loop %d\n",i,loop[i])
rendezvous:
        bar_wait(barrier)
critical:
        group=group*10+loop[i]
        assert(group==1 || group==11 || group==111 ||
               group==1112 || group==11122 || group==111222 ||
               group==1112223 || group==11122233 || group==111222333)
        printf("Th(%d): loop %d passed with %d\n",i,loop[i],group)

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

    bar_init(barrier,N)

    atomic {
        for (i: 1 .. THREADS) {
            run Th(i)
        }
    }
    _nr_pr == 1 ->
        assert(barrier._turnstile == 0)
        assert(barrier._turnstile2 == 0)
}
