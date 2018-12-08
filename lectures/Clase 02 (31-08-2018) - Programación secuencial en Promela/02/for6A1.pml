active proctype for_example() {
    int i=1;

    do
    :: i <= 10 -> printf("i = %d\n", i); i++
    :: else -> break
    od
}
