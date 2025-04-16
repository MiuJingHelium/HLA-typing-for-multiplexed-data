#!/bin/bash

STAGES=("E1" "M1" "L1") # 

for stage in ${STAGES[@]}; do

    SAMPLES=$(ls HLA-typing/${stage}) # list sample dir

    for sample in ${SAMPLES[@]}; do
        cp HLA-genotype-consolidated/${sample}*.tsv HLA-typing/${stage}/${sample}/
        
    done
    
done