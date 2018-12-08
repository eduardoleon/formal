/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

#include "for.h"
active proctype P() {
	int N = 10;
	int sum = 0;
	
	for (i, 1, N)
		sum = sum + i
	rof (i);
	printf("The sum of the first %d numbers = %d\n", N, sum);
}
