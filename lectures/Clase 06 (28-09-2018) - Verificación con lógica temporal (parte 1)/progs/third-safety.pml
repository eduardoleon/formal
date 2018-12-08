#define mutex (critical <= 1)

bool wantP = false, wantQ = false
byte critical = 0

active proctype P() {
    do
    :: wantP = true
       !wantQ
       critical++
       critical--
       wantP = false
    od
}

active proctype Q() {	
    do 
    :: wantQ = true
       !wantP
       critical++
       critical--
       wantQ = false
    od
}
