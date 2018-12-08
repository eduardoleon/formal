/*
   A "Hello World" Promela model for SPIN
   Theo C. Ruys - SPIN Beginners' Tutorial
   spinroot.com/spin/Doc/SpinTutorial.pdf
*/

active proctype Hello() {
    printf("Hello process, my pid is: %d\n", _pid)
}

init {
    int lastpid;

    printf("init process, my pid is: %d\n", _pid);
    lastpid = run Hello();
    printf("last pid was: %d\n", lastpid);
}

/*

*/

