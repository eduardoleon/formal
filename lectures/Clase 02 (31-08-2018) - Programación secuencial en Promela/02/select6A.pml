active proctype select_example() {
    int i

    do
    :: i == 4 -> break
    :: else -> select (i : 1 .. 4)
               printf("i = %d\n", i)
    od
}
