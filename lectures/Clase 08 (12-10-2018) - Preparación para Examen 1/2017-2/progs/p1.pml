byte x = 0

active proctype A() {
    byte t

    t = x
    x = 2*t
    t = x
    x = 2*t
}

active proctype B() {
    byte t

    x = 1
    t = x
    x = t + 1
}

init {
    _nr_pr == 1
    assert(x == 100)
}
