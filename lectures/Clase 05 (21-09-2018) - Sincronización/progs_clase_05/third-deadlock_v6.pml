/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

bool wantP = false, wantQ = false

active proctype P() {
    do
    ::
		printf("Non critical section P\n")
        wantP = true
		!wantQ
		printf("Critical section P\n")
        wantP = false
	od
}

active proctype Q() {	
	do 
	:: 	
        printf("Non critical section Q\n")
        wantQ = true
        !wantP
        printf("Critical section Q\n")
        wantQ = false
	od
}
