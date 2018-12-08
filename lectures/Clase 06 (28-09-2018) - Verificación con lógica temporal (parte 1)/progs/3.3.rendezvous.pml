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

    3.2.rendezvous.pml: all possible sequences
*/

int x = 0

proctype A() {
  x = 10*x + 1
  x = 10*x + 2
}

proctype B() {
  x = 10*x + 3
  x = 10*x + 4
}

init {
  atomic { run A(); run B() }
  _nr_pr == 1
  printf("x = %d\n", x)
  assert(x==1234 || x==1324 || x==1342 || x== 3412 || x==3142 || x==3124)
/* must be prohibited: 3412 and 1234 */
}
