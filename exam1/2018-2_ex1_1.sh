#!/bin/sh
spin -run 2018-2_ex1_1.pml | expand > 2018-2_ex1_1.out
./pan -D > 2018-2_ex1_1.dot
dot -Tpdf 2018-2_ex1_1.dot -o 2018-2_ex1_1.pdf
