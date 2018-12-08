bool csP = false, csQ = false



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
