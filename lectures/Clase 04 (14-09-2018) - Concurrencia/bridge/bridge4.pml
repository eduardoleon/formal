#define max(a,b) ((a>b) -> a : b)
#define right (a+b+c+d)

active proctype Bridge() {

    bit a = 0, b = 0, c = 0, d = 0, f = 0     /* all on the left bank */
    byte ta = 1, tb = 2, tc = 5, td = 10, t = 0

    do
    :: !a && !b && !f ->
            a = 1; b = 1; f = 1; t = t + max(ta,tb)
            printf("(a,b)-->, t = %d\n", t)
    :: !a && !c && !f ->
            a = 1; c = 1; f = 1; t = t + max(ta,tc)
            printf("(a,c)-->, t = %d\n", t)
    :: !a && !d && !f ->
            a = 1; d = 1; f = 1; t = t + max(ta,td)
            printf("(a,d)-->, t = %d\n", t)
    :: !b && !c && !f ->
            b = 1; c = 1; f = 1; t = t + max(tb,tc)
            printf("(b,c)-->, t = %d\n", t)
    :: !b && !d && !f ->
            b = 1; d = 1; f = 1; t = t + max(tb,td)
            printf("(b,d)-->, t = %d\n", t)
    :: !c && !d && !f ->
            c = 1; d = 1; f = 1; t = t + max(tc,td)
            printf("(c,d)-->, t = %d\n", t)
    :: a && f && (!b || !c || !d) ->
            a = 0; f = 0; t = t + ta
            printf("<--a, t = %d\n", t)
    :: b && f && (!a || !c || !d) ->
            b = 0; f = 0; t = t + tb
            printf("<--b, t = %d\n", t)
    :: c && f && (!a || !b || !d) ->
            c = 0; f = 0; t = t + tc
            printf("<--c, t = %d\n", t)
    :: d && f && (!a || !b || !c) ->
            d = 0; f = 0; t = t + td
            printf("<--d, t = %d\n", t)
    :: right == 4 -> break
    od
    printf("tiempo total = %d\n", t)
    assert(t == 7)
}

/*
vk@kaperna ~/clases/mf/progs $ spin bridge4.pml 
      (a,b)-->, t = 2
      <--a, t = 3
      (a,c)-->, t = 8
      <--a, t = 9
      (a,d)-->, t = 19
      tiempo total = 19
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
#processes: 1
 37:	proc  0 (Bridge:1) bridge4.pml:43 (state 63)
1 process created

vk@kaperna ~/clases/mf/progs $ spin -a bridge4.pml
 
vk@kaperna ~/clases/mf/progs $ gcc pan.c -o pan

vk@kaperna ~/clases/mf/progs $ ./pan
hint: this search is more efficient if pan.c is compiled -DSAFETY
pan:1: assertion violated (t==7) (at depth 5)
pan: wrote bridge4.pml.trail

(Spin Version 6.4.3 -- 16 December 2014)
Warning: Search not completed
        + Partial Order Reduction

Full statespace search for:
        never claim             - (none specified)
        assertion violations    +
        acceptance   cycles     - (not selected)
        invalid end states      +

State-vector 16 byte, depth reached 5, errors: 1
        6 states, stored
        0 states, matched
        6 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.000       equivalent memory usage for states (stored*(State-vector + overhead))
    0.287       actual memory usage for states
  128.000       memory used for hash table (-w24)
    0.534       memory used for DFS stack (-m10000)
  128.730       total actual memory usage



pan: elapsed time 0 seconds

vk@kaperna ~/clases/mf/progs $ ./pan -e
hint: this search is more efficient if pan.c is compiled -DSAFETY
pan:1: assertion violated (t==7) (at depth 5)
pan: wrote bridge4.pml1.trail
pan: wrote bridge4.pml2.trail
pan: wrote bridge4.pml3.trail
pan: wrote bridge4.pml4.trail
pan: wrote bridge4.pml5.trail
pan: wrote bridge4.pml6.trail
pan: wrote bridge4.pml7.trail
pan: wrote bridge4.pml8.trail
pan: wrote bridge4.pml9.trail
pan: wrote bridge4.pml10.trail
pan: wrote bridge4.pml11.trail
pan: wrote bridge4.pml12.trail
pan: wrote bridge4.pml13.trail
pan: wrote bridge4.pml14.trail
pan: wrote bridge4.pml15.trail

(Spin Version 6.4.3 -- 16 December 2014)
        + Partial Order Reduction

Full statespace search for:
        never claim             - (none specified)
        assertion violations    +
        acceptance   cycles     - (not selected)
        invalid end states      +

State-vector 16 byte, depth reached 7, errors: 15
      118 states, stored
       75 states, matched
      193 transitions (= stored+matched)
        0 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.005       equivalent memory usage for states (stored*(State-vector + overhead))
    0.287       actual memory usage for states
  128.000       memory used for hash table (-w24)
    0.534       memory used for DFS stack (-m10000)
  128.730       total actual memory usage


unreached in proctype Bridge
	(0 of 64 states)

pan: elapsed time 0.01 seconds

vk@kaperna ~/clases/mf/progs $ spin -t1 bridge4.pml 
      (a,b)-->, t = 2
      <--a, t = 3
      (a,c)-->, t = 8
      <--a, t = 9
      (a,d)-->, t = 19
      tiempo total = 19
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t2 bridge4.pml 
      (a,b)-->, t = 2
      <--a, t = 3
      (a,c)-->, t = 8
      <--b, t = 10
      (b,d)-->, t = 20
      tiempo total = 20
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t3 bridge4.pml 
      (a,b)-->, t = 2
      <--a, t = 3
      (a,c)-->, t = 8
      <--c, t = 13
      (c,d)-->, t = 23
      tiempo total = 23
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t4 bridge4.pml 
      (a,b)-->, t = 2
      <--a, t = 3
      (a,d)-->, t = 13
      <--d, t = 23
      (c,d)-->, t = 33
      tiempo total = 33
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t5 bridge4.pml 
      (a,b)-->, t = 2
      <--a, t = 3
      (c,d)-->, t = 13
      <--b, t = 15
      (a,b)-->, t = 17
      tiempo total = 17
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t6 bridge4.pml 
      (a,b)-->, t = 2
      <--b, t = 4
      (b,c)-->, t = 9
      <--b, t = 11
      (b,d)-->, t = 21
      tiempo total = 21
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t7 bridge4.pml 
      (a,b)-->, t = 2
      <--b, t = 4
      (b,c)-->, t = 9
      <--c, t = 14
      (c,d)-->, t = 24
      tiempo total = 24
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t8 bridge4.pml 
      (a,b)-->, t = 2
      <--b, t = 4
      (b,d)-->, t = 14
      <--d, t = 24
      (c,d)-->, t = 34
      tiempo total = 34
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t9 bridge4.pml 
      (a,c)-->, t = 5
      <--a, t = 6
      (a,d)-->, t = 16
      <--c, t = 21
      (b,c)-->, t = 26
      tiempo total = 26
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t10 bridge4.pml 
      (a,c)-->, t = 5
      <--a, t = 6
      (a,d)-->, t = 16
      <--d, t = 26
      (b,d)-->, t = 36
      tiempo total = 36
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t11 bridge4.pml 
      (a,c)-->, t = 5
      <--c, t = 10
      (b,c)-->, t = 15
      <--b, t = 17
      (b,d)-->, t = 27
      tiempo total = 27
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t12 bridge4.pml 
      (a,c)-->, t = 5
      <--c, t = 10
      (b,c)-->, t = 15
      <--c, t = 20
      (c,d)-->, t = 30
      tiempo total = 30
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t13 bridge4.pml 
      (a,c)-->, t = 5
      <--c, t = 10
      (b,d)-->, t = 20
      <--d, t = 30
      (c,d)-->, t = 40
      tiempo total = 40
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t14 bridge4.pml 
      (a,d)-->, t = 10
      <--d, t = 20
      (b,c)-->, t = 25
      <--b, t = 27
      (b,d)-->, t = 37
      tiempo total = 37
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

vk@kaperna ~/clases/mf/progs $ spin -t15 bridge4.pml 
      (a,d)-->, t = 10
      <--d, t = 20
      (b,d)-->, t = 30
      <--d, t = 40
      (c,d)-->, t = 50
      tiempo total = 50
spin: bridge4.pml:43, Error: assertion violated
spin: text of failed assertion: assert((t==7))
spin: trail ends after 6 steps
#processes: 1
  6:	proc  0 (Bridge:1) bridge4.pml:46 (state 64) <valid end state>
1 process created

*/
