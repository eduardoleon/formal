/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */
/* PSMC, pp.177-178
   vk, 2015
*/

#define N 2
byte clock = 0

proctype T(byte ID; byte period; byte exec) {
    byte next = 0
    byte deadline = period
    bool done = false
    do
    ::  atomic {
            (clock >= next) && (clock < deadline) ->
                printf("Task %d: executed from %d ", ID, clock)
                clock = clock + exec    /* executed */
                printf("to %d\n", clock)
                next = next + period
                done = true
        }
    ::  atomic {
            clock >= deadline ->
                assert done
                deadline = deadline + period
                done = false
        }
    od
}

proctype Idle() {
    do
    :: 	atomic {	
            timeout -> {
            clock++
            printf("Idle, clock ticking: %d\n", clock)
            }
        }
    od
}

init {
    atomic {
        run Idle()
        run T(0, 2, 1)
        run T(1, 5, 2)
    }
}
