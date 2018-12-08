/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.8 Queue
    3.8.4 Exclusive queue solution

    vk, 2017
*/

#include "Semaphore.h"

#define N 6

Semaphore mutex=1, leaderQueue=0, followerQueue=0, rendezvous=0
byte      leaders=0, followers=0

proctype Leader(byte i) {
    wait(mutex)
    if
    :: followers > 0 ->
        followers--
        assert(followerQueue == 0)
        signal(followerQueue)
    :: else ->
        leaders++
        signal(mutex)
        wait(leaderQueue)
    fi

dance:
    printf("leader %d: to dance\n",i)
    wait(rendezvous)
    printf("leader %d: dancing\n",i)
    signal(mutex)
}

proctype Follower(byte i) {
    wait(mutex)
    if
    :: leaders > 0 ->
        leaders--
        assert(leaderQueue == 0)
        signal(leaderQueue)
    :: else ->
        followers++
        signal(mutex)
        wait(followerQueue)
    fi

dance:
    atomic {
        signal(rendezvous)
        printf("follower %d: dancing\n",i)
    }
}

init {
    byte i

    atomic {
        for (i: 0 .. N) {
            if
            :: i % 2 -> run Leader(i)
            :: else  -> run Follower(i)
            fi
        }
    }
}
