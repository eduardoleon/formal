/*  spin_lock_v6b.pml  */

bit   in_use = false
byte  cs = 0

proctype P(bit i) {
  do
  :: atomic {
       in_use == false ->      /* while (in_use == 1) ; i.e. busy wait */
         in_use = true
     }
     cs++
     printf("P(%d) has entered CS\n", i)
     assert(cs == 1)
     cs--
     in_use = false
  od
}

init {
  atomic { run P(0); run P(1) }
}
