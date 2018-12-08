/* light_0C.pml */

mtype = { red, yellow, green };

active proctype L() {
    mtype light = green;

    do
    :: light = yellow; light = red; light = green
    od
}
