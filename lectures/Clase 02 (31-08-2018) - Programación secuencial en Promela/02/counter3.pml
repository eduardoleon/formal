byte count = 4

active proctype counter()
{
    do
    ::  count != 0 ->
            printf("count = %d\n", count)
            if
            :: count++
            :: count--
            fi
    ::  else ->
            break
    od
}
