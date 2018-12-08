#define max(a,b) ((a>b) -> a : b)
#define r_bank (a+b+c)

active proctype Bridge() {

    bit a = 0, b = 0, c = 0, f = 0        // all on the left bank
    byte ta = 1, tb = 2, tc = 5, t = 0    // times of persons A,B and C

    do
    :: !f ->                 // flashlight on the left bank
             f = 1
             if
             :: !a && !b ->  // A and B
                            a = 1; b = 1; t = t + tb
                            printf("(A,B)-->, t = %d\n", t)
             :: !a && !c ->  // A and C
                            a = 1; c = 1; t = t + tc
                            printf("(A,C)-->, t = %d\n", t)
             :: !b && !c ->  // B and C
                            b = 1; c = 1; t = t + tc
                            printf("(B,C)-->, t = %d\n", t)
             fi
    :: f ->                  // flashlight on the right bank
             if
             :: r_bank == 3 -> break
             :: a ->
                     a = 0; f = 0; t = t + ta
                     printf("<--A, t = %d\n", t)
             :: b ->
                     b = 0; f = 0; t = t + tb
                     printf("<--B, t = %d\n", t)
             :: c ->
                     c = 0; f = 0; t = t + tc
                     printf("<--C, t = %d\n", t)
             fi
    od
    printf("tiempo total = %d\n", t)
}

/*
vk@kaperna ~/clases/mf/04/bridge $ spin bridge3_v1.pml 
      (A,C)-->, t = 5
      <--C, t = 10
      (B,C)-->, t = 15
      <--A, t = 16
      timeout
#processes: 1
 36:	proc  0 (Bridge:1) bridge3_v1.pml:12 (state 18)
1 process created
*/
