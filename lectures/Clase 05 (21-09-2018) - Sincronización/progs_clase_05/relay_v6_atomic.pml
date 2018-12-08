/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

byte input, output, i

active proctype Source() {
  for (i : 1 .. 10) {
    input == 0
    input = i
  }
}

active proctype Relay() {
  do
  :: atomic {
       input != 0
       output == 0
       if
       :: output = input
       :: skip
       fi
     }
     input = 0
  od
}

active proctype Destination() {
  do
  :: output != 0
     printf("Output = %d\n", output)
     output = 0
  od
}
