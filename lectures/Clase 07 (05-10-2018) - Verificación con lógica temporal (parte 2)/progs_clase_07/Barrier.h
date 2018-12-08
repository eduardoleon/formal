
typedef Barrier {
    byte      _n
    byte      _count
    Semaphore _mutex
    Semaphore _turnstile
    Semaphore _turnstile2
}

inline bar_init(bar,n) {
    bar._n          = n
    bar._count      = 0
    bar._mutex      = 1
    bar._turnstile  = 0
    bar._turnstile2 = 0
}

inline bar_phase1(bar) {
    wait(bar._mutex)
        bar._count++    /* atomic here */
        if
        :: bar._count == bar._n ->
            signalN(bar._turnstile,bar._n)
        :: else
        fi
    signal(bar._mutex)
    wait(bar._turnstile)
}

inline bar_phase2(bar) {
    wait(bar._mutex)
        bar._count--        /* atomic here */
        if
        :: bar._count == 0 ->
            signalN(bar._turnstile2,bar._n)
        :: else
        fi
    signal(bar._mutex)
    wait(bar._turnstile2)
}

inline bar_wait(bar) {
    bar_phase1(bar)
    bar_phase2(bar)
}

