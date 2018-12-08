#define NRDRS   5
#define NWRTS   2
#define MAXRDRQ 20
#define MAXWRRQ 20

chan readrequest  = [MAXRDRQ] of { byte, chan }
chan writerequest = [MAXWRRQ] of { byte, chan }
chan finished     = [MAXRDRQ+MAXWRRQ] of { byte }
chan mbox[NRDRS+NWRTS+1] = [MAXRDRQ+MAXWRRQ] of { bool }

byte count = 100

proctype Reader(byte i) {
    readrequest ! i,mbox[i]
    atomic {
        mbox[i] ? _
        printf("Reader %d\n",i)
    }
    finished ! i
}

proctype Writer(byte i) {
    writerequest ! i,mbox[i]
    atomic {
        mbox[i] ? _
        printf("Writer %d\n",i)
    }
    finished ! i
}

proctype Controller() {
    byte p

end:
    do
    ::  count > 0 ->
        if
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
                    run Writer(i)
            ::  else ->
                    run Reader(i)
            fi
        }
        run Controller()
    }
}
