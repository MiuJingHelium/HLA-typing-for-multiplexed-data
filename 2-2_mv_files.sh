#!/bin/bash

STAGES=("E1" "M1" "L1") # 

mkdir -p HLA-genotype-consolidated/Samples/

for stage in ${STAGES[@]}; do

    SAMPLES=$(ls HLA-typing/${stage}) # list sample dir

    for sample in ${SAMPLES[@]}; do
        cp HLA-typing/${stage}/${sample}/*.tsv HLA-genotype-consolidated/Samples/
        
    done
    
done