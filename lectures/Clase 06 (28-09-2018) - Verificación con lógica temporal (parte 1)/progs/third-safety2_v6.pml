bool wantP = false, wantQ = false, csP = false, csQ = false

ltl { []!(csP && csQ) }

active proctype P() {
    do
    :: wantP = true
       !wantQ
       csP = true
       csP = false
       wantP = false
    od
}

active proctype Q() {	
    do 
    :: wantQ = true
       !wantP
       csQ = true
       csQ = false
       wantQ = false
    od
}
