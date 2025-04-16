
library(data.table)
library(tidyverse)

indir <- "HLA-genotype-consolidated/Samples/"
outdir <- "HLA-genotype-consolidated/"

gene.files <- list.files(path = indir, pattern = "\\.genes.tsv$")
genotype.files <- list.files(path = indir, pattern = "\\.genotypes.tsv$")
```


samples_gene <- unlist(lapply(gene.files,function(x){unlist(strsplit(x, split = "[.]"))[1]})) # nolint
samples_genotype <- unlist(lapply(genotype.files,function(x){unlist(strsplit(x, split = "[.]"))[1]})) # nolint

gene.table.list <- lapply(gene.files, function(x){read.table(paste0(indir,x), sep = "\t", header = T)}) # nolint
genotype.table.list <- lapply(genotype.files, function(x){read.table(paste0(indir,x), sep = "\t", header = T)}) # nolint

gene_df <- Reduce(function(x,y){full_join(x, y, by = intersect(colnames(x),colnames(y)))}, gene.table.list) # nolint

write.table(gene_df, file = paste0(outdir,"consolidated_HLA_gene.tsv"),sep = "\t", col.names = T, row.names = F, quote = F) # nolint

geno_df <- Reduce(function(x,y){full_join(x, y, by = intersect(colnames(x),colnames(y)))}, genotype.table.list) # nolint

write.table(geno_df, file = paste0(outdir,"consolidated_HLA_genotype.tsv"),sep = "\t", col.names = T, row.names = F, quote = F) # nolint




