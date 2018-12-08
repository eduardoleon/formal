/*  The Little Book of Semaphores (2.1.5)
    by A. Downey

    Chapter 3. Basic synchronization patterns

    3.1 Signaling
                   Thread A                Thread 2
                   1  statement a1         1  sem.wait()
                   2  sem.signal()         2  statement b1

    We want to guarantee that a1 happens before b1 (serialization problem).

*/

#define wait(sem)   atomic { sem > 0; sem-- }
#define signal(sem) sem++

byte sem = 0
byte x = 0

proctype A() {
  x = 1
  signal(sem)
}

proctype B() {
  wait(sem)
  x = 2
}

init {
  atomic { run A(); run B() }
  _nr_pr == 1
  assert( x == 2 )
}
