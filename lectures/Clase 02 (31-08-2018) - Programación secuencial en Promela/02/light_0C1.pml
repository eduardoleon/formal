/* light_0C1.pml */

mtype = { red, yellow, green }

active proctype L() {
    mtype light = green

    do
    :: light = yellow
       light = red
       light = green
    od
}
