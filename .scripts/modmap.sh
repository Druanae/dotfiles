#!/bin/sh
for i in {1..100}; do
    xmodmap ~/.Xmodmap;
    sleep 2;
done
