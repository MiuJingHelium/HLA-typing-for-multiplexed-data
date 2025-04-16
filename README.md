# HLA-typing-for-multiplexed-data

## Step 0: Prepare txt files over barcodes for each sample
0_retrieve-barcodes_for_UMITools.R

The original plan was to use UMITools, but split-bam worked fine. The sample name extraction didn't work well with the pattern I used for naming the barcode files. To make things easier, naming the barcode txt files by sample name would be enough.

## Step 1: Split bam files using barcodes from demultiplexing step
1-0_subset-bam_job.sh --> 1-1_subset-bam.sh

One of the steps was to extract the sample names from the barcode files. For files containing "T" or "t", the pattern extraction failed, so some of the sample names were manually corrected. There are probably ways to properly extract the sample names. If the files are directly named by samples, then the extraction can be easier done with extracting strings before ".txt". 

## Step 2: run arcasHLA over sample-specific bam files
2-0_HLA-typing_job.sh -> 2-1_arcasHLA.sh

*2-2_mv_files.sh for automatically move relevant files to the correct location. The operation I intended to perform was `cp` instead of `mv`.*

To smoothly run the genotyping step, specific versions of the reference are needed. 

## Step 3: consolidate gene.tsv and genotype.tsv from all samples.

3_consolidate-HLA-typing-results.R


