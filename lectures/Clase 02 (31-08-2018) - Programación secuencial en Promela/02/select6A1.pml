active proctype select_example() {
    int i

    do
    :: i == 4 -> break
    :: else -> i = 1
               do
               :: i < 4 -> i++
               :: break
               od
               printf("i = %d\n", i)
    od
}
