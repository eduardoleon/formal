/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

bool wantP = false, wantQ = false
bool csp = false

ltl p1 { <>csp }

active proctype P() {
  do
  :: wantP = true
     do
     :: wantQ -> wantP = false; wantP = true
     :: else -> break
     od
     csp = true
     csp = false
     wantP = false
  od
}

active proctype Q() {	
  do 
  :: wantQ = true
     do
     :: wantP -> wantQ = false; wantQ = true
     :: else -> break
     od
     wantQ = false
  od
}
