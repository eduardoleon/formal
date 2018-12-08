int cycles

active proctype testWithSelect() {
    select(cycles: 26 .. 31)

    assert(cycles >= 26 && cycles <= 31)
}
