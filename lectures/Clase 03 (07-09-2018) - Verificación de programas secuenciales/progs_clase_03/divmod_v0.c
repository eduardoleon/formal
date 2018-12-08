#include <stdio.h>

void divmod(int x, int y, int* q, int* r)
{
    *r=x; *q=0;
    while (*r>y) {
        *r=*r-y; (*q)++;
    }
}

void main(void)
{
    int x, y=7, q, r, i;

    for (i=0; i<5; i++) {
        x=100+i;
        divmod(x,y,&q,&r); 
        printf("%d = %d*%d + %d\n",x,y,q,r);
    }
}
