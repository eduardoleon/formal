/*** Example 3 ***/

chan q = [1] of { bool }
bool ok = false

active proctype high () priority 10
{   bool x

    q?x    /* highest priotity, but blocked */
    ok = true
}


active proctype low () priority 5
{
    atomic {
        q!true      /* executes first  */
        assert (ok) /* assertion fails */
    }
}
