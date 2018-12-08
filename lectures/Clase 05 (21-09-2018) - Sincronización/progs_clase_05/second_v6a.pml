/*  second_v6a.pml  */

bit  c[2] = 1
byte cs = 0

proctype P(bit i) {
  do
  :: c[1-i] == 1 ->
       c[i]=0
       cs++
       printf("P(%d) has entered CS\n", i)
       assert(cs == 1)
       cs--
       c[i]=1
  od
}

init {
  atomic { run P(0); run P(1) }
}
