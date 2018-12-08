#define MAX  4       /* 1..2, 3..4 */
#define HALF MAX/2

#define f(x) (3 - x) /* P will find it */

#define ok (Pexited && Qexited)    /* both are terminated */

ltl { <>ok }

bool found
bool Pexited=false, Qexited=false  /* ghost variables */

active proctype P() {
  byte i=HALF

  found=false
  do
  :: found ->
              break
  :: else ->
              i++
              if
              :: i==MAX+1 ->
                             i=HALF+1
              :: else
              fi
              found = (f(i) == 0)
  od
  Pexited=true
}

active proctype Q() {
  byte j = HALF+1

  found = false
  do
  :: found ->
              break
  :: else ->
              j--
              if
              :: j==0 ->
                         j=HALF
              :: else
              fi
              found = (f(j) == 0)
  od
  Qexited=true
}
