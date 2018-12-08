byte b, w
b = 100
w = 100

init {
    do
    :: w + b <= 1 -> break
    :: w     >= 2 -> w = w - 2; b = b + 1
    :: else       -> b = b - 1
    od
    assert(b == 1)
}
