/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

active proctype P() {
	int a = 1, b = -4, c = 4;
	int disc;
	disc = b * b - 4 * a * c;
	if
	:: disc < 0  -> printf("disc = %d: no real roots\n", disc)
	:: disc == 0 -> printf("disc = %d: duplicate real roots\n", disc)
	:: disc > 0  -> printf("disc = %d: two real roots\n", disc)
	fi
}
