/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
	int x = 15, y = 20;
	int a, b;
	a = x; b = y;
	do
	:: a > b -> a = a - b
	:: b > a -> b = b - a
	:: a == b -> break
	od;
	printf("The GCD of %d and %d = %d\n", x, y, a);
	assert (x % a == 0 && y % a == 0)
}
