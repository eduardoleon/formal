/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
	int a = 5, b = 5;
	int max;
	int branch;
	if
	:: a >= b -> max = a; branch = 1;
	:: b >= a -> max = b; branch = 2;
	fi;
	printf("The maximum of %d and %d = %d by branch %d\n",
			a, b, max, branch);
}
