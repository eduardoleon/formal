byte count = 4

active proctype counter()
{
    do
    ::  printf("count = %d\n", count)
        count != 0 ->
            if
            :: count++
            :: count--
            fi
    ::  else ->
            break
    od
}
