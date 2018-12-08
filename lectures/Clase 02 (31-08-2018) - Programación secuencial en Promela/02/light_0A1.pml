/* light_0A1.pml */

mtype = { red, yellow, green } /* ; <- optional since 6.3.0 */

active proctype L() {

    mtype light = green

    printf("red = %d, yellow = %d, green = %d\n", red, yellow, green)

    printf("light = %e (%d)\n", light, light)

    light = yellow
    printf("light = %e (%d)\n", light, light)
    light = red	
    printf("light = %e (%d)\n", light, light)
}
