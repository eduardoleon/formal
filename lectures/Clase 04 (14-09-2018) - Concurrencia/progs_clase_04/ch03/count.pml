/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

#include "for.h"
byte    n = 0;

proctype P() {
    byte temp;
    for (i, 1, 10)
        temp = n;
        n = temp + 1
    rof (i)
}
init {
    atomic {
        run P();
        run P()
    }
    (_nr_pr == 1);
    printf("The value is %d\n", n);
    assert (n > 2)
}
