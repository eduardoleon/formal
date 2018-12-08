bool flag

active proctype p() {
    do
    :: flag -> break
    :: else -> skip
    od
}

active proctype q() {
    flag = true
}
