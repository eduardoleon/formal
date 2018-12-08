#define NRDRS   5
#define NWRTS   2
#define MAXRDRQ 20
#define MAXWRRQ 20

chan readrequest  = [MAXRDRQ] of { byte }
chan writerequest = [MAXWRRQ] of { byte }
chan finished     = [MAXRDRQ+MAXWRRQ] of { byte }
chan mbox[NRDRS+NWRTS+1] = [MAXRDRQ+MAXWRRQ] of { bool }

int count = 100
mtype = { reader, writer }
byte nr = 0, nw = 0

proctype ReaderWriter(byte i; mtype who) {
    chan ch
    if
    :: who == reader -> ch = readrequest
    :: else -> ch = writerequest
    fi

    ch ! i
    atomic {
        mbox[i] ? _
        printf("%e %d\n",who,i)
    }
    if
    :: who == reader -> nr++
    :: else -> nw++
    fi
    assert(nw < 2)
    assert((nw > 0 && nr == 0) || (nw == 0 && nr > 0))
    atomic {
        if
        :: who == reader -> nr--
        :: else -> nw--
        fi
        finished ! i
    }
}

proctype Controller() {
    byte p

    do
    ::  count > 0 ->
end:    if
        ::  nempty(finished) ->
                atomic {
                    finished ? p
                    printf("finished %d\n",p)
                }
                count++
        ::  empty(finished) && nempty(writerequest) ->
                atomic {
                writerequest ? p
                    printf("request from Writer %d\n",p)
                }
                count = count - 100
        ::  empty(finished) && empty(writerequest) && nempty(readrequest) ->
                atomic {
                    readrequest ? p
                    printf("request from Reader %d\n",p)
                }
                count--
                atomic {
                    mbox[p] ! true
                    printf("OK to Reader %d\n",p)
                }
        fi
    ::  count == 0 ->
            atomic {
                mbox[p] ! true
                printf("OK to Writer %d\n",p)
            }
            atomic {
                finished ? p
                printf("finished Writer %d\n",p)
            }
            count = 100
    ::  count < 0 ->
            atomic {
                finished ? p
                printf("finished Writer %d\n",p)
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
