/*  The Little Book of Semaphores (2.2.1)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.1 Signaling
    3.3 Rendezvous
                   Thread A                Thread 2
                   1  statement a1         1  statement b1
                   2  statement a2         2  statement b2

    We want to guarantee that a1 happens before b2 and b1 happens before a2:
        a1,b1,b2,a2; a1,b1,a2,b2; b1,a1,a2,b2; b1,a1,b2,a2
    prohibiting
        b1,b2,a1,a2; a1,a2,b1,b2

    3.3.3 Deadlock #1
*/

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte aArrived = 0, bArrived = 0;
int x = 0

proctype A() {
  x = 10*x + 1
  wait(bArrived)
  signal(aArrived)
  x = 10*x + 2
}

proctype B() {
  x = 10*x + 3
  wait(aArrived)
  signal(bArrived)
  x = 10*x + 4
}

init {
  atomic { run A(); run B() }
  _nr_pr == 1
  assert(x!=1234 && x!=3412)
}
