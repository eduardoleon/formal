/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
  int dividend = 15;
  int divisor  = 4;
  int quotient, remainder;

  assert (dividend >= 0 && divisor > 0);

  quotient = 0;
  remainder = dividend;
  do
  :: remainder >= divisor ->
       quotient++;
       remainder = remainder - divisor
  :: else ->
       break
  od;
  printf("%d divided by %d = %d, remainder = %d\n",
         dividend, divisor, quotient, remainder);

  assert (0 <= remainder && remainder < divisor);
  assert (dividend == quotient * divisor + remainder);
}
