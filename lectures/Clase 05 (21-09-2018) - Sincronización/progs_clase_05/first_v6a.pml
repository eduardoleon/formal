/*  first_v6a.pml  */

bit  turn = 0
byte cs = 0

proctype P(bit i) {
  do
  :: turn == i ->    /* while (turn != i) ; i.e. busy wait */
       cs++
       printf("P(%d) has entered CS\n", i)
       assert(cs == 1)
       cs--
       turn = 1 - i
  od
}

init {
  atomic { run P(0); run P(1) }
}
