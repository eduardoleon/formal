/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
	int a = 5, b = 5, max;
	if
	:: a >= b -> max = a;
	:: b >= a -> max = b+1;
	fi;
	assert (a >= b -> max == a : max == b);
}
