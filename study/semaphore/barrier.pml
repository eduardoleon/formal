#define workers 3
#include "barrier.hdr"

Barrier bar
int     group

ltl { <> (group == 111222333) }

proctype Th() {
    byte loop = 1
    
    do
      :: bar_phase(bar, 0)
         bar_phase(bar, 1)
         
         group = 10*group + loop
         if
           :: loop == 3 -> break
           :: else      -> loop++
         fi
    od
}

init {
    byte i
    bar_init(bar, workers)
    atomic { for (i : 1 .. workers) { run Th() } }
}
