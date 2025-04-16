
library(Seurat)
library(data.table)
library(tidyverse)



RDSdir <- "RDS/"
outdir <- "individual_barcodes/"
if (!dir.exists(outdir)) dir.create(outdir)


whole <- readRDS(paste0(RDSdir,"whole_integrated_wTCR_woUD_V1p5.Rds"))

meta <- whole@meta.data
meta$barcode <- unlist(lapply(meta$barcode, function(x){unlist(strsplit(x,split = "_"))[3]}))

table(meta$patient_id,meta$stage)

# export barcode.txt for each patient with stage information

stages <- c("Early","Mid","Late")
for (s in stages){
  sample_meta <- meta %>% filter(stage == s)
  patient_ids <- unique(sample_meta$patient_id)
  for (p in patient_ids){
    patiend.bc <- sample_meta$barcode[sample_meta$patient_id == p]
    write.table(patiend.bc,file = paste0(outdir,"barcodes_",s,"_",p,".txt"),sep = "\t", quote = F, col.names = F,row.names = F) # nolint: line_length_linter.
  }
}


