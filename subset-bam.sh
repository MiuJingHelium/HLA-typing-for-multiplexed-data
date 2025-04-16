#!/bin/bash
WD=$1
INDIR=$2
sample=$3
mkdir -p $WD/tmp/$sample
export TMPDIR=$WD/tmp/$sample

STORAGE_LOC=/storage1/fs1/martyomov/Active/collaborations/carisa/Campisi/ALS_human/

cd $WD

case "$sample" in
    "L1")
    BAM_dir=${STORAGE_LOC}/align_outs/${sample}_CD8/outs/per_sample_outs/${sample}_CD8/count
    BAM=${BAM_dir}/sample_alignments.bam
    ID_LIST=(ALS4003 ALS4009 ALS4019 C67 Control_ALS4010 Control_ALS4017)

    for ID in ${ID_LIST[@]}; do
        patient_id=Late_${ID}
        OUTDIR=${WD}/split_bam/${sample}/${patient_id}/
        BC=${INDIR}/${sample}/barcodes_${patient_id}.txt
        mkdir -p ${OUTDIR}
        ./subset-bam/subset-bam \
            --bam $BAM \
            --cell-barcodes $BC \
            --out-bam ${OUTDIR}/${patient_id}.bam \
            --cores 4

        done
    ;;
    "M1")
        BAM_dir=${STORAGE_LOC}/align_outs/${sample}_CD8/outs/per_sample_outs/${sample}_CD8/count
        BAM=${BAM_dir}/sample_alignments.bam
        BC_list=$(ls ${INDIR}/${sample})

        for f in ${BC_list[@]}; do
            patient_id=$(grep -oP '(?<=barcodes_)[^.txt]*' <<< $f)
            OUTDIR=${WD}/split_bam/${sample}/${patient_id}/
            BC=${INDIR}/${sample}/${f}
            mkdir -p ${OUTDIR}
            ./subset-bam/subset-bam \
                --bam $BAM \
                --cell-barcodes $BC \
                --out-bam ${OUTDIR}/${patient_id}.bam \
                --cores 4 \
                --log-level info

        done
    ;;
    "E1")
        BAM_dir=${STORAGE_LOC}/align_outs/${sample}_CD8/outs/per_sample_outs/${sample}_CD8/count
        BAM=${BAM_dir}/sample_alignments.bam
        BC_list=$(ls ${INDIR}/${sample})

        for f in ${BC_list[@]}; do
            patient_id=$(grep -oP '(?<=barcodes_)[^.txt]*' <<< $f)
            OUTDIR=${WD}/split_bam/${sample}/${patient_id}/
            BC=${INDIR}/${sample}/${f}
            mkdir -p ${OUTDIR}
            ./subset-bam/subset-bam \
                --bam $BAM \
                --cell-barcodes $BC \
                --out-bam ${OUTDIR}/${patient_id}.bam \
                --cores 4 \
                --log-level info

        done
    ;;
esac
    
  