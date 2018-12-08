#define SQ(x,y) !b.r[x].s[y] -> b.r[x].s[y] = z+1
#define H(v,w)  b.r[v].s[0]==w && ...
#define V(v,w)  b.r[0].s[v]==w && ...
#define UD(w)   b.r[0].s[0]==w && ...
#define DD(w)   b.r[2].s[0]==w && ...

typedef Row   { byte s[3]; };
typedef Board { Row  r[3]; };

Board b
bit z, won

init {
    do
    :: atomic { /* do not store intermediate states */
        !won ->
            if  /* all valid moves */
            :: SQ(0,0)  :: SQ(0,1)  :: SQ(0,2)
            ...
            ...
            :: else -> break /* a draw: game over */
            fi

            if  /* winning positions */
            :: H(0,z+1) || ... ||\
               ...
               ...  ->
                /* print winning position */
                printf("%d %d %d\n%d %d %d\n%d %d %d\n",
                    b.r[0].s[0], ...
                    ...
                    ...
                won = true /* and force a stop */
            :: else -> z = 1 - z                  /* continue */
            fi
       } /* end of atomic */
    od
}
