#!/bin/sh
for i in {1..4}; do
    spin -T -n$i signaling.pml | expand > signaling.out$i
done
