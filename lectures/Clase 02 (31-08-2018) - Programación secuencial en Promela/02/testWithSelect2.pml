int cycles = 26

active proctype testWithSelect2() {
    do
    :: cycles < 31 -> cycles++
    :: break
    od

    assert(cycles >= 26 && cycles <= 31)
}
