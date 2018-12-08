#include "Semaphore.h"

Semaphore a2=0, b1=0, b2=0, b3=0, c1=0, c3=0   // estaba en 1

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
    signal(b3)          // faltaba esto
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
