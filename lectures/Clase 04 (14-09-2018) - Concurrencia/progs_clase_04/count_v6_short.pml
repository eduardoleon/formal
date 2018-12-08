byte    n = 0

proctype P() {
    byte i
    for (i : 1 .. 10) {
        n = n + 1
    }
}

init {
    atomic {
        run P()
        run P()
    }
    (_nr_pr == 1)
    assert (n == 20)
}
