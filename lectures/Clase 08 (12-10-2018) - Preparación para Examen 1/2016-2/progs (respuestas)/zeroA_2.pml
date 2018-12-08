#define MAX  4
#define HALF MAX/2

#define f(x) (3 - x)

#define ok (P@Pexited && Q@Qexited)

ltl { <>ok }

bool found

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
Pexited:
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
Qexited:
}
