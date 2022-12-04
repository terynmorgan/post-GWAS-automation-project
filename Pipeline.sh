#!/bin/bash

input_gwas_efo_id=$gwas_efo_id 

Rscript Query_GWAS.R ${input_gwas_efo_id} "GWAS_Variant_IDs.txt"
Rscript Filter_Variant_IDs.R "GWAS_Variant_IDs.txt" "GWAS_Filtered_Variant_IDs.txt"
Rscript Query_Ensembl.R "GWAS_Filtered_Variant_IDs.txt"

echo
echo "__DONE__"
echo 

exit 0
