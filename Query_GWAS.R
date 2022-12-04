#!/usr/bin/env Rscript

install.packages("gwasrapidd")
install.packages("tibble")
install.packages("tidyverse")
library(gwasrapidd)
library(tibble)
library(tidyverse)

# Using GWAS API
args <- commandArgs(trailingOnly = TRUE)
EFO_id <- args[1]

# Gets tibble of variants from EFO_id
variants_from_efo <- get_variants(efo_id = EFO_id)
variant_ensembl_ids <- variants_from_efo@ensembl_ids 

# Export file
write.csv(variant_ensembl_ids[1:2], file = args[2])

