
#define Semaphore   byte

#define wait(sem)       atomic { sem > 0; sem-- }
#define signal(sem)     sem++
#define signalN(sem,NN) for (_i: 1 .. NN) { sem++ } /* no atomic */

byte _i=0

