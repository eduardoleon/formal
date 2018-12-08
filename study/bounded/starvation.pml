#include "bounded.hdr"

active [2] proctype P() {
    pid me = _pid
    pid you = 1 - me
    
    do
    :: want[me] = true
bw:    do
       :: want[you]
          want[me] = false
          want[me] = true
       :: else
          break
       od
cs:    want[me] = false
    od
}
