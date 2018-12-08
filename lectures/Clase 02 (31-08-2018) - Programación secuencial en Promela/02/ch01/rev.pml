/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
  int value = 123;
  int reversed;
  reversed = 
    (value % 10) * 100 +
    ((value / 10) % 10) * 10 +
    (value / 100);
  printf("value = %d, reversed = %d\n", value, reversed)
}
