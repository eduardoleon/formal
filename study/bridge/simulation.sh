#!/bin/sh
spin -run -e simulation.pml
for i in {1..58}; do spin -t$i simulation.pml >> simulation.errors; done
grep 'total' simulation.errors | grep -v 'assert' | sort | uniq > simulation.total
