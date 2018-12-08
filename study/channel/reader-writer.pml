#define NRDRS   5
#define NWRTS   2
#define MAXRDRS 100
#define MAXRDRQ 20
#define MAXWRRQ 20

chan readrequest  = [MAXRDRQ] of { chan }
chan writerequest = [MAXWRRQ] of { chan }
chan finished     = [MAXRDRQ+MAXWRRQ] of { mtype }

mtype = { reader, writer }
byte nr = 0, nw = 0, pass = 0, group = 0

ltl { <> (group == 2) }

proctype ReaderWriter(mtype who) {
    chan reply = [1] of { bool }

    if
    :: who == reader -> readrequest ! reply; pass = pass | 1
    :: who == writer -> writerequest ! reply; pass = pass | 2
    fi

    reply ? _                   // receive ok to access

    if
    :: who == reader -> nr++
    :: who == writer -> nw++
    fi

    assert((nw == 1 && nr == 0) || (nw == 0 && nr > 0))

    if
    :: who == reader -> nr--; group = 10 * group + 1
    :: who == writer -> nw--; group = 10 * group + 2
    fi

    finished ! who              // send to finished
}

proctype Controller() {
    int count = MAXRDRS
    chan readreply, writereply

    pass & 1
    pass & 2

    do
    ::  count > 0 ->    // readers are working
end:    if
        ::  nempty(finished) ->
                finished ? reader
                count++
        ::  empty(finished) && nempty(writerequest) ->
                writerequest ? writereply
                count = count - MAXRDRS     // no more readers
        ::  empty(finished) && empty(writerequest) && nempty(readrequest) ->
                readrequest ? readreply
                count--
                readreply ! true
        fi
    ::  count == 0 ->   // there aren't readers
            writereply ! true
            finished ? writer
            count = MAXRDRS
    ::  count < 0 ->    // writer is waiting because readers access
            finished ? reader
            count++
    od
}

init {
    byte i

    atomic {
        for (i : 1 .. NRDRS) { run ReaderWriter(reader) }
        for (i : 1 .. NWRTS) { run ReaderWriter(writer) }
        run Controller()
    }
}
