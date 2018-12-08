#include "Semaphore.h"

Semaphore a2=1, b1=1, b2=1, b3=1, c1=1, c3=1

proctype A() {
    wait(b2)
A1: printf("A1\n")
A2: printf("A2\n")
    signal(a2)
    wait(c3)
A3: printf("A3\n")
}

proctype B() {
    wait(c1)
B1: printf("B1\n")
    signal(b1)
B2: printf("B2\n")
    signal(b2)
    wait(a2)
B3: printf("B3\n")
}

proctype C() {
C1: printf("C1\n")
    signal(c1)
    wait(b1)
C2: printf("C2\n")
    wait(b3)
C3: printf("C3\n")
    signal(c3)
}

init {
    atomic { run A(); run B(); run C() }
}
