/* light_0A2.pml */

// requires Spin Version 6.4.8 or later

mtype { one, two, three }

mtype:fruit = { apple, pear, banana }

mtype:sizes = { small, medium, large }

proctype recipient(mtype:fruit z; mtype y) {
    atomic {
        printf("z: "); printm(z); printf("\n")
        printf("y: "); printm(y); printf("\n")
    }
}

init {
    mtype numbers
    mtype:fruit snack
    mtype:sizes package

    run recipient(pear, two)

    numbers = one
    snack = pear
    package = large

    printm(numbers)
    printm(snack)
    printm(package)
    printf("\n")
}
