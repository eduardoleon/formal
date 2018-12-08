#define p       (z+1)
#define SQ(x,y) !b.r[x].s[y] -> b.r[x].s[y] = p
#define H(v)    (b.r[v].s[0]==p && b.r[v].s[1]==p && b.r[v].s[2]==p)
#define V(v)    (b.r[0].s[v]==p && b.r[1].s[v]==p && b.r[2].s[v]==p)
#define UD      (b.r[0].s[0]==p && b.r[1].s[1]==p && b.r[2].s[2]==p)
#define DD      (b.r[2].s[0]==p && b.r[1].s[1]==p && b.r[0].s[2]==p)

typedef Row   { byte s[3]; };
typedef Board { Row  r[3]; };

Board b
byte w
bit z, f

#define XREF 2
#define YREF 1

init {
    /* force the first move */
    b.r[XREF].s[YREF] = 1
    z = 1
    
    do
    :: w -> break
    :: atomic { /* do not store intermediate states */
        else ->
            if  /* all valid moves */
            :: SQ(0,0)
            :: SQ(0,1)
            :: SQ(0,2)
            :: SQ(1,0)
            :: SQ(1,1)
            :: SQ(1,2)
            :: SQ(2,0)
            :: SQ(2,1)
            :: SQ(2,2)
            :: else -> w = 3
            fi
            
            printf("%d %d %d\n%d %d %d\n%d %d %d\n\n",
               b.r[0].s[0], b.r[0].s[1], b.r[0].s[2],
               b.r[1].s[0], b.r[1].s[1], b.r[1].s[2],
               b.r[2].s[0], b.r[2].s[1], b.r[2].s[2])
            
            if  /* winning positions */
            :: H(0) || H(1) || H(2) ||\
               V(0) || V(1) || V(2) ||\
               UD || DD ->
               w = p
            :: else -> z = 1 - z                  /* continue */
            fi
       } /* end of atomic */
    od
    
    assert(w == 1)
}
