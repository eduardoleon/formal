#define limit 3
#define total 10
#include "semaphore.hdr"

Semaphore sem
byte      count

ltl { [] (count <= limit) }

proctype Th() {
    sem_wait(sem)
    count++
    count--
    sem_signal(sem)
}

init {
    byte i
    sem_init(sem, limit)
    atomic { for (i : 1 .. total) { run Th() } }
}
