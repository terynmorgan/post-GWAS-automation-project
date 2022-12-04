#!/usr/bin/env Rscript

# Read data
args <- commandArgs(trailingOnly = TRUE)
variant_ensembl_ids <- read.table(file = args[1], sep = ',')

# Drops index column
variant_ensembl_ids <- variant_ensembl_ids[, 2:ncol(variant_ensembl_ids)]

# Fixed column names
colnames(variant_ensembl_ids) <- variant_ensembl_ids[1, 1:2]
variant_ensembl_ids <- variant_ensembl_ids [-1, ]

# Filters variants by duplicates and gene mappings
filter_variant_ids <- variant_ensembl_ids[!(duplicated(variant_ensembl_ids$variant_id)) & !(duplicated(variant_ensembl_ids$gene_name)),]

# Export file
lapply(filter_variant_ids[,1], write, args[2], append = TRUE)