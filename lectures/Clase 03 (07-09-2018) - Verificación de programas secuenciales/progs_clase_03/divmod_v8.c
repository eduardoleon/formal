#include <assert.h>
#include <stdio.h>

void divmod(int x, int y, int* q, int* r)
{
    assert(0<=x && 0<y);
    *r=x; *q=0;
    assert(0<=*r && 0<y && x==y*(*q)+(*r));
    while (*r>=y) {
        assert(0<=*r && 0<y && y<=*r && x==y*(*q)+(*r));
        *r=*r-y; (*q)++;
        assert(0<=*r && 0<y && x==y*(*q)+(*r));
    }
    assert(0<=*r && *r<y && x==y*(*q)+(*r));
}

void main(void)
{
    int x, y=7, q, r, i;

    for (i=0; i<7; i++) {
        x=100+i;
        divmod(x,y,&q,&r); 
        printf("%d = %d*%d + %d\n",x,y,q,r);
    }
}
