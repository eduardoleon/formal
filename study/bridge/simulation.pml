mtype = { left, right }

mtype side[4] = left
int   delay[4] = { 1, 2, 5, 10 }
int   pick, cycle, round, total

/* this assertion will fail, because there is a better solution */
//ltl { <> (total > 17) }

inline shift(source, target) {
    /* select who goes */
    if
    :: side[0] == source -> pick = 0
    :: side[1] == source -> pick = 1
    :: side[2] == source -> pick = 2
    :: side[3] == source -> pick = 3
    fi
    
    /* update the elapsed time for this round */
    if
    :: round < delay[pick] -> round = delay[pick]
    :: else                -> skip
    fi
    
    /* make them actually go */
    side[pick] = target
}

inline totalize() {
    /* update the total elapsed time */
    total = total + round
    round = 0
}

init {
    do
    :: /* send two people to the right side */
       shift(left, right)
       shift(left, right)
       totalize()
         
       /* if everyone is already on the right side, stop,
        * otherwise send someone back to the left side */
       if
       :: cycle == 2 -> break
       :: else ->
          shift(right, left)
          totalize()
          cycle++
       fi
    od
    
    assert(total == 0)
}
