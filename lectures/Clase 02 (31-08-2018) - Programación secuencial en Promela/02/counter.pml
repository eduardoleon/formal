byte count

active proctype counter()
{
    do
    :: count++
    :: count--
    :: (count == 0) ->
        break
    od
}
