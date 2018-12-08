bool csP = false, csQ = false

ltl p1 { []!(csP && csQ) }

active proctype P() {
  do ::  !csQ
         csP = true
         csP = false
  od
}

active proctype Q() {
  do ::  !csP
         csQ = true
         csQ = false
  od
}
