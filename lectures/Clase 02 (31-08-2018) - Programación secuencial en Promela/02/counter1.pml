byte count

active proctype counter()
{
    do
    ::  count != 0 ->
            if
            :: count++
            :: count--
            fi
    ::  else ->
            break
    od
}
