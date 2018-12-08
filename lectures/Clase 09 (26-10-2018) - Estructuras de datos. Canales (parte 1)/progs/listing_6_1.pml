
active proctype P() {
    int a[5] = { 0, 10, 20, 30, 40 }
    int sum = 0, i = 0

    for (i in a) {
        sum = sum + a[i]
    }
    printf("The sum of the numbers = %d\n", sum)
}
