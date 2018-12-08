#define NRDRS   5
#define NWRTS   2
#define TOTALT  20

chan readrequest  = [NRDRS] of { byte }
chan writerequest = [NWRTS] of { byte }
chan finished     = [NRDRS+NWRTS] of { byte }
chan mbox[NRDRS+NWRTS] = [1] of { bool }

mtype = { reader, writer }
byte start[NRDRS+NWRTS]
byte nr = 0, nw = 0
byte t = 0

proctype ReaderWriter(byte i; mtype who) {
    chan ch

    atomic {
        if
        :: who == reader -> ch = readrequest
        :: else -> ch = writerequest
        fi
        (start[i] <= t)
        ch ! i
        mbox[i] ? _
        printf("t=%d: %e %d\n",t,who,i)
        if
        :: who == reader -> nr++
        :: else -> nw++
        fi
        t++
    }
    assert(nw < 2)
    assert((nw > 0 && nr == 0) || (nw == 0 && nr > 0))
    atomic {
        if
        :: who == reader ->
            (t >= start[i]+2)
            nr--
        :: else ->
            (t >= start[i]+5)
            nw--
        fi
        finished ! i
    }
}

proctype Controller() {
    byte r, w, rdrcount=0

end:
    do
    ::  nempty(finished) || nempty(writerequest) || nempty(readrequest)
        if
        ::  nempty(finished) ->
                atomic {
                    finished ? r
                    printf("t=%d: finished Reader %d\n",t,r)
                    rdrcount--
                }
        ::  empty(finished) && nempty(writerequest) ->
                atomic {
                    writerequest ? w
                    printf("t=%d: request from Writer %d\n",t,w)
                }
                do
                ::  rdrcount == 0 -> break
                ::  else ->
                        atomic {
                            finished ? r
                            printf("t=%d: finished Reader %d\n",t,r)
                            rdrcount--
                        }
                od
                atomic {
                    mbox[w] ! true
                    printf("t=%d: OK to Writer %d\n",t,w)
                }
                atomic {
                    finished ? w
                    printf("t=%d: finished Writer %d\n",t,w)
                }
        ::  empty(finished) && empty(writerequest) && nempty(readrequest) ->
                atomic {
                    readrequest ? r
                    printf("t=%d: request from Reader %d\n",t,r)
                    rdrcount++
                }
                atomic {
                    mbox[r] ! true
                    printf("t=%d: OK to Reader %d\n",t,r)
                }
        fi
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
        for (i : 0 .. NRDRS+NWRTS-1) {  /* R0,R1,W2,R3,R4,W5,R6 */
            if
            ::  i == 2 || i == 5 ->
                    run ReaderWriter(i,writer)
            ::  else ->
                    run ReaderWriter(i,reader)
            fi
            start[i] = i
        }
    }
    run Idle()
    (_nr_pr == 2)
}
