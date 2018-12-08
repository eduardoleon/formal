#define NRDRS   5       // number of readers
#define NWRTS   2       // number of writers
#define MAXRDRS 100
#define MAXRDRQ 20
#define MAXWRRQ 20
#define RDRUNTIME 3     // reader's run time
#define WRRUNTIME 5     // writer's run time
#define TOTALT  20      // total simulation time

/*
R6        ........+++   (start at 6, wait to 14 and run to 17)
W5       ....+++++      (start at 5, wait to 9 and run to 14)
R4      ..........+++   (start at 4, wait to 14 and run to 17)
R3     ...........+++   (start at 3, wait to 14 and run to 17)
W2    ..+++++           (start at 2, wait to 4 and run to 9)
R1   +++                (start at 1, run to 4
R0  +++                 (start at 0, run to 3) 
    0----5---10---15---20
*/

chan readrequest  = [MAXRDRQ] of { byte }
chan writerequest = [MAXWRRQ] of { byte }
chan finished     = [MAXRDRQ+MAXWRRQ] of { byte }
chan mbox[NRDRS+NWRTS+1] = [MAXRDRQ+MAXWRRQ] of { bool }

int count = MAXRDRS
mtype = { reader, writer }
byte start[NRDRS+NWRTS]
byte waiting[NRDRS+NWRTS]
byte nr = 0, nw = 0
byte t = 0

proctype ReaderWriter(byte i; mtype who) {
    chan ch
    if
    :: who == reader -> ch = readrequest
    :: else -> ch = writerequest
    fi
    (start[i] <= t)
    atomic {
        ch ! i                  // send request
        printf("t=%d: %e %d send a request\n",t,who,i)
    }
    atomic {
        mbox[i] ? _             // receive ok to access
        waiting[i] = t - start[i]
        printf("t=%d: %e %d received ok waiting %d\n",t,who,i,waiting[i])
    }
    if                          // inc counter
    :: who == reader -> nr++
    :: else -> nw++
    fi
    t++
    assert(nw < 2)
    assert((nw > 0 && nr == 0) || (nw == 0 && nr > 0))
    atomic {
        if                      // dec counter
        :: who == reader ->
            (t >= start[i]+waiting[i]+RDRUNTIME)
            nr--
        :: else ->
            (t >= start[i]+waiting[i]+WRRUNTIME)
            nw--
        fi
        finished ! i            // send to finished queue
    }
}

proctype Controller() {
    byte r,w    // process id

    do
    ::  count > 0 ->    // readers are welcome
        assert(nw == 0)
end:    if
        ::  nempty(finished) ->
                atomic {
                    finished ? r
                    printf("t=%d: finished Reader %d\n",t,r)
                }
                count++
                assert(nr + count > 0 && nr + count <= MAXRDRS)
        ::  empty(finished) && nempty(writerequest) ->
                atomic {
                writerequest ? w
                    printf("t=%d: request from Writer %d\n",t,w)
                }
                count = count - MAXRDRS    // no more readers
                assert(nr + count == 0)
        ::  empty(finished) && empty(writerequest) && nempty(readrequest) ->
                atomic {
                    readrequest ? r
                    printf("t=%d: request from Reader %d\n",t,r)
                }
                count--
                assert(count > 0 && count < MAXRDRS)
                atomic {
                    mbox[r] ! true  // send ok to reader
                    printf("t=%d: OK to Reader %d\n",t,r)
                }
        fi
    ::  count == 0 ->   // there aren't readers, writer may go
            assert(nr == 0 && nw == 0)
            atomic {
                mbox[w] ! true  // send ok to writer
                printf("t=%d: OK to Writer %d\n",t,w)
            }
            atomic {
                finished ? w    // wait writer finishing
                printf("t=%d: finished Writer %d\n",t,w)
            }
            count = MAXRDRS     // initial state
    ::  count < 0 ->    // writer is waiting because readers access
            assert(nr + count == 0)
            atomic {
                finished ? r
                printf("t=%d: finished Reader %d\n",t,r)
            }
            count++
    od
}

proctype Idle() {
    do
    ::  atomic {
            timeout ->
                if
                ::  t >= TOTALT || _nr_pr == 3 -> break
                ::  else ->
                        printf("t: %d -> %d\n",t,t+1)
                        t++
                fi
        }
    od
}

init {
    byte i

    atomic {
        run Controller()
        run Idle()
        for (i : 0 .. NRDRS+NWRTS-1) {  /* R0,R1,W2,R3,R4,W5,R6 */
            if
            ::  i == 2 || i == 5 ->
                    run ReaderWriter(i,writer)
            ::  else ->
                    run ReaderWriter(i,reader)
            fi
            start[i] = i    // start times: 0,1,2,3,...
        }
    }
    (_nr_pr == 2)
}
