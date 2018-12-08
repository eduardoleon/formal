byte c, x

active proctype A() {
    byte i, t
    for (i : 1 .. 5) {
        t = x
        x = t + 1
    }
    c = c + 1
}

active proctype B() {
    byte i, t
    t = x
    x = t << 1
    c = c + 1
}

init {
    c == 2
    assert(x == 0)
}

