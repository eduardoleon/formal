int i = 0

active proctype testWithJump() {
  checking:
    do
    :: i > 4 -> goto exitloop
    :: else -> printf("%d",i)
               i++
    od
  exitloop:
    printf("%d\n",i)
}
