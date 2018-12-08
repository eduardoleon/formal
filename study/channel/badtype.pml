chan request = [0] of { byte }
chan reply = [0] of { byte }

// Falta un campo en la respuesta.
// En la simulación, por defecto SPIN coloca cero.

active proctype Server() {
    byte client
    request ? client
    reply ! _pid, client
}

active proctype Client() {
    byte server, client
    request ! _pid
    reply ? server, client
    assert(client == _pid)
}
