active proctype A(int a) {
    printf("A: %d\n", a)
}

active [4] proctype B() {
    printf("B: %d\n", _pid)
    run A(_pid)
}
