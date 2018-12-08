#include "semaphore.hdr"

Semaphore sem[2]

ltl { !P[0]@w U P[1]@s }

active [2] proctype P() {
    pid me = _pid
    pid you = 1 - me
    
    sem_signal(sem[me])
s:  sem_wait(sem[you])
w:
}
