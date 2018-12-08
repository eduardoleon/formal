chan req = [0] of { byte }

active [2] proctype Client() {
    do :: req ! _pid od
}

active proctype Server() {
    byte id
    do :: req ? id -> printf("Client %d\n", id) od
}
