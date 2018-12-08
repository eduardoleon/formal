/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
	int N = 10;
	int sum = 0;
	
	byte i; 
	i = 1; 
	do 
	:: i > N -> break 
	:: else ->
		sum = sum + i;
		i++
	od;
	printf("The sum of the first %d numbers = %d\n", N, sum);
}
