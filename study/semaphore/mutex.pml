#include "semaphore.hdr"

Semaphore sem
byte      count

ltl { <> (count == 2) }

proctype Th(byte name) {
    byte temp
    sem_wait(sem)
    temp = count
    count = temp + 1
    sem_signal(sem)
}

init {
    sem_init(sem, 1)
    atomic { run Th('A'); run Th('B') }
}
