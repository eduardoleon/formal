#define NRDRS   5
#define NWRTS   2
#define MAXRDRS 100
#define MAXRDRQ 20
#define MAXWRRQ 20

chan readrequest  = [MAXRDRQ] of { byte }
chan writerequest = [MAXWRRQ] of { byte }
chan finished     = [MAXRDRQ+MAXWRRQ] of { byte }
chan mbox[NRDRS+NWRTS+1] = [MAXRDRQ+MAXWRRQ] of { bool }

int count = MAXRDRS
mtype = { reader, writer }
byte nr = 0, nw = 0

proctype ReaderWriter(byte i; mtype who) {
    chan ch
    if
    :: who == reader -> ch = readrequest
    :: else -> ch = writerequest
    fi

    ch ! i                      // send request
    atomic {
        mbox[i] ? _             // receive ok to access
        printf("%e %d\n",who,i)
    }
    if                          // inc counter
    :: who == reader -> nr++
    :: else -> nw++
    fi
    assert(nw < 2)
    assert((nw > 0 && nr == 0) || (nw == 0 && nr > 0))
    atomic {
        if                      // dec counter
        :: who == reader -> nr--
        :: else -> nw--
        fi
        finished ! i            // send to finished
    }
}

proctype Controller() {
    byte r,w    // process id

    do
    ::  count > 0 ->    // readers are working
end:    if
        ::  nempty(finished) ->
                atomic {
                    finished ? r
                    printf("finished Reader %d\n",r)
                }
                count++
        ::  empty(finished) && nempty(writerequest) ->
                atomic {
                writerequest ? w
                    printf("request from Writer %d\n",w)
                }
                count = count - 100     // no more readers
        ::  empty(finished) && empty(writerequest) && nempty(readrequest) ->
                atomic {
                    readrequest ? r
                    printf("request from Reader %d\n",r)
                }
                count--
                atomic {
                    mbox[r] ! true  // send ok to reader
                    printf("OK to Reader %d\n",r)
                }
        fi
    ::  count == 0 ->   // there aren't readers
            atomic {
                mbox[w] ! true  // send ok to writer
                printf("OK to Writer %d\n",w)
            }
            atomic {
                finished ? w    // wait writer finishing
                printf("finished Writer %d\n",w)
            }
            count = 100
    ::  count < 0 ->    // writer is waiting because readers access
            atomic {
                finished ? r
                printf("finished Reader %d\n",r)
            }
            count++
    od
}

init {
    byte i

    atomic {
        for (i : 1 .. NRDRS+NWRTS) {  /* R1,R2,W3,R4,W5,R6,R7 */
            if
            ::  i == 3 || i == 5 ->
                    run ReaderWriter(i,writer)
            ::  else ->
                    run ReaderWriter(i,reader)
            fi
        }
        run Controller()
    }
}
