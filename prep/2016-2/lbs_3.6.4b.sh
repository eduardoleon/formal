#!/bin/sh
spin -run -e lbs_3.6.4b.pml | expand > lbs_3.6.4b.result
for i in {1..3}; do
    spin -t$i lbs_3.6.4b.pml | expand >> lbs_3.6.4b.errors
done
grep 'barrier' lbs_3.6.4b.errors | grep -v 'assert' > lbs_3.6.4b.final
