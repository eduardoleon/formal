#!/bin/sh
spin -run -e gt_1_1.pml | expand > gt_1_1.result
for i in {1..22}; do
    spin -t$i gt_1_1.pml | expand >> gt_1_1.errors;
done
grep 'x' gt_1_1.errors | grep -v 'assert' > gt_1_1.final
