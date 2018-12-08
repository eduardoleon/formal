/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

int n = 0;
bool flag = false;

active proctype p() {
	do
	::  flag -> break;
	::  else -> n = 1 - n;
	od
}

active proctype q() {
	flag = true
}
