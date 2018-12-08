#include "semaphore.hdr"

#define NR 4
#define NE 3
#define TE 10

Semaphore ss, rs, es1, es2, mut
byte      rc = NR, ec = NE

proctype Reindeer(byte id) {
    do
    :: sem_wait(mut)
           printf("Reindeer %d: I'm back, Santa!\n", id)
           rc--
           if
           :: rc
           :: else -> sem_signal(ss)
           fi
       sem_signal(mut)
       
       sem_wait(rs)
       printf("Reindeer %d: I'm off to Rapa Nui!\n", id)
    od
}

proctype Elf(byte id) {
    do
    :: sem_wait(es1)
       sem_wait(mut)
           printf("Elf %d: Santa, help me!\n", id)
           ec--
           if
           :: ec   -> sem_signal(es1)
           :: else -> sem_signal(ss)
           fi
       sem_signal(mut)
       
       sem_wait(es2)
       sem_wait(mut)
           printf("Elf %d: Thanks, Santa!\n", id)
           ec--
           if
           :: ec
           :: else -> ec = NE; sem_signal(es1)
           fi
       sem_signal(mut)
    od
}

init {
    byte id
    
    sem_init(es1, 1)
    sem_init(mut, 1)
    atomic {
        for (id : 1 .. NR) { run Reindeer(id) }
        for (id : 1 .. TE) { run Elf(id) }
    }
    
    do
    :: sem_wait(ss)
       sem_wait(mut)
           if
           :: !rc -> printf("Santa: Let's deliver those presents! Ho-ho-ho!\n")
                     rc = NR; sem_init(rs, NR)
           :: !ec -> printf("Santa: Let me help you, guys.\n")
                     ec = NE; sem_init(es2, NE)
           fi
       sem_signal(mut)
    od
}
