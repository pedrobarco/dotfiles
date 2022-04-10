#!/bin/bash

plugins=(
    "ctx"
    "ns"
    "neat"
    "print-env"
)

for p in "${plugins[@]}"
do
    kubectl krew install "$p"
done
