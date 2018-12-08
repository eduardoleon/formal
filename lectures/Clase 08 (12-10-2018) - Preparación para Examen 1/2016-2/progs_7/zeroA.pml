#define MAX  100    /* 0..49, 50..99 */
#define HALF MAX/2

#define f(x) (54 - x)

bool found

active proctype P() {
  byte i=HALF

  found=false
  do
  :: found ->
              break
  :: else ->
              found = (f(i) == 0)
              if
              :: i==MAX-1 ->
                             i=HALF
              :: else     ->
                             i++
              fi
  od
}

active proctype Q() {
  byte j = HALF-1

  found = false
  do
  :: found ->
              break
  :: else ->
              found = (f(j) == 0)
              if
              :: j==0 ->
                         j=HALF-1
              :: else ->
                         j--
              fi
  od
}
