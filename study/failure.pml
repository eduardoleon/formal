byte turn = 1

ltl { <>Q@cs }

active proctype P() {
    do
    :: if
       :: true -> skip
       :: true -> false
       fi
       turn == 1
       turn = 2
    od
}

active proctype Q() {
    do
    :: turn == 2
cs:    turn = 1
    od
}
