#define pairs 6
#include "semaphore.hdr"

mtype = { male, female }

Semaphore mutex, convo1, convo2
Semaphore queue[3]
byte      count[3]

inline male_dance() {
    printf("Male %d: Shall we dance?\n", id)
    sem_signal(convo1)
    sem_wait(convo2)
    printf("Male %d: Take my hand.\n\n", id)
    sem_signal(mutex)
}

inline female_dance() {
    sem_wait(convo1)
    printf("Female %d: Okay...\n", id)
    sem_signal(convo2)
}

proctype Dancer(byte id; mtype me, you) {
    sem_wait(mutex)
    
    if
    :: count[you]
       count[you]--
       sem_signal(queue[you])
    :: else
       count[me]++
       sem_signal(mutex)
       sem_wait(queue[me])
    fi
    
    if
    :: me == male
       male_dance()
    :: me == female
       female_dance()
    fi
}

init {
    byte id
    sem_init(mutex, 1)
    atomic {
        for (id : 1 .. pairs) {
            run Dancer(id, male, female)
            run Dancer(id, female, male)
        }
    }
}
