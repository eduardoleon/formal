/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */
/* PSMC, pp.175-177
   vk, 2015
*/

#define N 2             /* number of processes */
byte clock = 0          /* models time */
bool done[N] = false    /* done before the deadline */

proctype T(byte ID; byte period; byte exec) {
    byte next = 0       /* next time to execute */
    do
    ::  d_step {
            clock >= next ->    /* is it time to execute? */
                printf("Task %d: executed from %d ", ID, clock)
                clock = clock + exec    /* executed */
                printf("to %d\n", clock)
                done[ID] = true         
                next = next + period    /* next time to execute */
        }
    od
}

proctype Watchdog(byte ID; byte period) {       /* for every task */
    byte deadline = period
    do
    ::  d_step {
            clock >= deadline ->
                assert done[ID]
                deadline = deadline + period
                done[ID] = false
        }
    od
}

proctype Idle() {
    do
    ::  d_step {	
            timeout -> {
                clock++
                printf("Idle, clock ticking: %d\n", clock)
            }
    }
    od
}

init {
    d_step {
        run Idle()
        run T(0, 2, 1)      /* Task ID, period, execution time */
        run Watchdog(0, 2) priority 3  /* Task ID, task deadline */
        run T(1, 5, 2)
        run Watchdog(1, 5) priority 3
        printf("init priority      = %d\n",get_priority(0))
        printf("Idle priority      = %d\n",get_priority(1))
        printf("Task0 priority     = %d\n",get_priority(2))
        printf("Watchdog0 priority = %d\n",get_priority(3))
        printf("Task1 priority     = %d\n",get_priority(4))
        printf("Watchdog1 priority = %d\n",get_priority(5))
    }
}
