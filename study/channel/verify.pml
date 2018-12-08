chan request = [4] of { byte, chan } // tiene buffer
byte count

// El canal de solicitudes tiene un buffer.
// Si quitamos el buffer, no habrá más de dos clientes a la vez.

active [2] proctype Server() {
    byte client
    chan reply
end:
    do :: request ? client, reply -> reply ! _pid od
}

active [4] proctype Client() {
    byte server
    chan reply = [0] of { byte }
    request ! _pid, reply
    count++
    assert(count <= 2)
    count--
    reply ? server
}
