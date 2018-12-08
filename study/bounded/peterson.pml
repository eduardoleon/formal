#include "bounded.hdr"

bool turn

active [2] proctype P() {
    pid me = _pid
    pid you = 1 - me
    
    do
    :: want[me] = true
       turn = you
bw:   !want[you] || turn == me
cs:    want[me] = false
    od
}
