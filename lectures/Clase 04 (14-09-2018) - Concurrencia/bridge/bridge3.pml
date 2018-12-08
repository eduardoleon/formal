#define max(a,b) ((a>b) -> a : b)
#define right (a+b+c)

active proctype Bridge() {

    bit a = 0, b = 0, c = 0, f = 0
    byte ta = 1, tb = 2, tc = 5, t = 0

    do
    :: !a && !b && !f ->
            a = 1; b = 1; f = 1; t = t + max(ta,tb)
            printf("(a,b)-->, t = %d\n", t)
    :: !a && !c && !f ->
            a = 1; c = 1; f = 1; t = t + max(ta,tc)
            printf("(a,c)-->, t = %d\n", t)
    :: !b && !c && !f ->
            b = 1; c = 1; f = 1; t = t + max(tb,tc)
            printf("(b,c)-->, t = %d\n", t)
    :: a && f && (!b || !c) ->
            a = 0; f = 0; t = t + ta
            printf("<--a, t = %d\n", t)
    :: b && f && (!a || !c) ->
            b = 0; f = 0; t = t + tb
            printf("<--b, t = %d\n", t)
    :: c && f && (!a || !b) ->
            c = 0; f = 0; t = t + tc
            printf("<--c, t = %d\n", t)
    :: right == 3 -> break
    od
    printf("tiempo total = %d\n", t)
    assert(t == 7)
//    otras soluciones?
//    todas las soluciones a la vez?
}

/*
vk@kaperna ~/clases/mf/progs $ spin -a bridge3.pml 

vk@kaperna ~/clases/mf/progs $ gcc -o pan pan.c

vk@kaperna ~/clases/mf/progs $ ./pan -e
hint: this search is more efficient if pan.c is compiled -DSAFETY
pan:1: assertion violated (t==7) (at depth 3)
pan: wrote bridge3.pml1.trail
pan: wrote bridge3.pml2.trail
pan: wrote bridge3.pml3.trail

(Spin Version 6.4.3 -- 16 December 2014)
	+ Partial Order Reduction

Full statespace search for:
	never claim         	- (none specified)
	assertion violations	+
	acceptance   cycles 	- (not selected)
	invalid end states	+

State-vector 16 byte, depth reached 5, errors: 3
       17 states, stored
        5 states, matched
       22 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.001	equivalent memory usage for states (stored*(State-vector + overhead))
    0.289	actual memory usage for states
  128.000	memory used for hash table (-w24)
    0.534	memory used for DFS stack (-m10000)
  128.730	total actual memory usage


unreached in proctype Bridge
	(0 of 41 states)

pan: elapsed time 0 seconds

vk@kaperna ~/clases/mf/progs $ spin -t1 -g bridge3.pml 
using statement merging
      (a,b)-->, t = 2
      <--a, t = 3
      (a,c)-->, t = 8
      tiempo total = 8
spin: bridge3.pml:31, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 4 steps
#processes: 1
  4:	proc  0 (Bridge:1) bridge3.pml:35 (state 41) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t2 -g bridge3.pml 
using statement merging
      (a,b)-->, t = 2
      <--b, t = 4
      (b,c)-->, t = 9
      tiempo total = 9
spin: bridge3.pml:31, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 4 steps
#processes: 1
  4:	proc  0 (Bridge:1) bridge3.pml:35 (state 41) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t3 -g bridge3.pml 
using statement merging
      (a,c)-->, t = 5
      <--c, t = 10
      (b,c)-->, t = 15
      tiempo total = 15
spin: bridge3.pml:31, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 4 steps
#processes: 1
  4:	proc  0 (Bridge:1) bridge3.pml:35 (state 41) <valid end state>
1 process created

*/
