#define N 5

inline write(ar) {
    d_step {
        for (i in ar) {
            printf("%d ", ar[i])
        }
        printf("\n")
    }
}

active proctype P() {
    int a[N] = 0, i

    write(a)
    for (i in a) {
        a[i] = i
    }
    write(a)
}
