#!/bin/sh
for i in {1..6}; do
    spin -run -ltl p$i signaling_verified.pml | expand > signaling_verified.result$i
done
