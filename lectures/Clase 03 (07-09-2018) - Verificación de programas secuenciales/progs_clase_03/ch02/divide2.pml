/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
	int dividend = 15, divisor  = 4;
	int quotient = 0, remainder = 0;
	int n = dividend;

	assert (dividend >= 0 && divisor > 0);

	do
	:: n != 0 ->
            assert (dividend == quotient * divisor + remainder + n);
			assert (0 <= remainder && remainder < divisor);
			if
			:: remainder + 1 == divisor -> 
				 quotient++; 
                 remainder = 0
			:: else ->
				 remainder++
			fi;
			n--
	:: else ->
			break
	od;
	printf("%d divided by %d = %d, remainder = %d\n",
			dividend, divisor, quotient, remainder);
	assert (dividend == quotient * divisor + remainder);
	assert (0 <= remainder && remainder < divisor);
}
