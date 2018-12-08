#include <stdio.h>

void divmod(int x, int y, int* q, int* r)
{
    printf("dividend x=%d, divisor y=%d\n",x,y);
    *r=x; *q=0;
    while (*r>y) {
        *r=*r-y; (*q)++;
    }
    printf("y*q + r = %d\n\n",y*(*q)+(*r));
}

void main(void)
{
    int x, y=7, q, r, i;

    for (i=0; i<5; i++) {
        x=100+i;
        divmod(x,y,&q,&r); 
    }
}
