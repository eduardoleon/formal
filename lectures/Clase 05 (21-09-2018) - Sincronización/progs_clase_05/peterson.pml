/* Peterson’s mutex algorithm, two parallel processes 0 and 1 */
bool flag[2] = false
bool turn = 0
byte count = 0

/* flag is initialized to all false, */
/* and turn has the initial value 0  */

active [2] proctype peterson()
{
    pid i = _pid; pid j = 1 - _pid
    /* Infinite loop */
again:
    /* [noncritical section] */
    flag[i] = true
    /* [trying section] */
    turn = i
    (flag[j] == false || turn != i)
    count++
    assert(count == 1)
    /* [critical section] */
    count--
    flag[i] = false
    goto again
}
