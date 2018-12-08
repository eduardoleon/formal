int cycles

active proctype testWithIf() {
    if
    ::  cycles = 26
    ::  cycles = 27
    ::  cycles = 28
    ::  cycles = 29
    ::  cycles = 30
    ::  cycles = 31
    fi

    assert(cycles >= 26 && cycles <= 31)
}
