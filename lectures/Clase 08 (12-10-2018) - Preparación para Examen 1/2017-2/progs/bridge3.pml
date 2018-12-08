#define max(a,b) ((a>b) -> a : b)
#define N        3

byte a[N] = 0      /* crossing times of N persons */
bool c[N] = false  /* nobody crossed */
byte t = 0         /* total time */

active proctype Bridge() {
    a[0] = 1; a[1] = 2; a[2] = 5

    do
    ::  c[0]&&c[1]&&c[2] -> break    /* todos cruzaron */
    ::  else ->
            if
            ::  !c[0]&&!c[1] -> c[0]=true; c[1]=true    /* cruzan 0+1 */
                                t=t+max(a[0],a[1])
                                printf("0,1 -->\n")
            ::  !c[0]&&!c[2] -> c[0]=true; c[2]=true    /* cruzan 0+2 */
                                t=t+max(a[0],a[2])
                                printf("0,2 -->\n")
            ::  !c[1]&&!c[2] -> c[1]=true; c[2]=true    /* cruzan 1+2 */
                                t=t+max(a[1],a[2])
                                printf("1,2 -->\n")
            ::   c[0]&&(c[1]||c[2]) -> c[0]=false       /* regresa 0 */
                                       t=t+a[0]
                                       printf("    <-- 0\n")
            ::   c[1]&&(c[0]||c[2]) -> c[1]=false       /* regresa 1 */
                                       t=t+a[1]
                                       printf("    <-- 1\n")
           ::    c[2]&&(c[0]||c[1]) -> c[2]=false       /* regresa 2 */
                                       t=t+a[2]
                                       printf("    <-- 2\n")
           fi
    od

    printf("total time = %d\n", t)
    assert(t==0)
}
