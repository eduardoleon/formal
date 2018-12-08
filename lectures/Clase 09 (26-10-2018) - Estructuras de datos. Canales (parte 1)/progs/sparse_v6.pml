/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

#define N 4

typedef ENTRY {
  byte row
  byte col
  int value
}

ENTRY a[N]

active proctype P() {
  int i = 0, r = 0, c = 0

  a[0].row = 0; a[0].col = 1; a[0].value = -5
  a[1].row = 0; a[1].col = 3; a[1].value = 8
  a[2].row = 2; a[2].col = 0; a[2].value = 20
  a[3].row = 3; a[3].col = 3; a[3].value = -3

  for (r in a) {
    for (c in a) {
      if
      :: i == N -> printf("0 ")
      :: i < N && r == a[i].row && c == a[i].col ->
             printf("%d ", a[i].value)
             i++
      :: else -> printf("0 ")
      fi
    }
    printf("\n")
  }
}
