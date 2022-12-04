#!/usr/bin/env Rscript

install.packages("httr")
install.packages("jsonlite")
install.packages("xml2")
install.packages("gsubfn")
library(httr)
library(jsonlite)
library(xml2)
library(gsubfn)

# Open text file 
main_dir <- getwd()
args <- commandArgs(trailingOnly = TRUE)
file <- args[1]
path <- file.path(main_dir, file)
df <- read.table(path, sep='\n')

# Creates folder to hold POST request of Ensembl API 
output_dir <- file.path(main_dir, "GWAS_RsIDs")

if (!dir.exists(output_dir)){
  dir.create(output_dir)
} else {
  print("Dir already exists!")
}

# Creates list of rsids from GWAS_rsids.txt
variant_rsids <- list()
for (rsid in df[1]){
  variant_rsids <- append(variant_rsids, rsid)
}

# Connection to Ensembl API
server <- "https://rest.ensembl.org"

# GET request for all calculated variant consequences
ext <- "/info/variation/consequence_types?"
r <- GET(paste(server, ext, sep = ""), content_type("application/json"))
stop_for_status(r)
response = content(r, "parsed")

# Add all SO_terms (most_severe_consequence) to a list 
consequence_terms = list()
for (lst in response){
  consequence_terms = append(consequence_terms, lst$SO_term)
}

# Creates folders labeled by most_severe_consequence term in GWAS_RsIDs folder
for (ele in consequence_terms){
  sub_dir <- file.path(output_dir, ele)
  if (!dir.exists(sub_dir)){
    dir.create(sub_dir)
  } 
  else {
    next
  }
}

# POST request function 
POST_requests = function(ext, rsid, file_name){
  
  r <- GET(paste(server, ext, sep = ""), content_type("application/json"))
  if (http_error(r) == TRUE){
    return (fn$identity("Error: `rsid`"))
  } else {
    response = content(r, "parsed")
    
    consequence_type = response$most_severe_consequence
    
    # Creates folders labeled by rsid in GWAS_RsIDs folder
    sub_dir <- file.path(output_dir, fn$identity("`consequence_type`/`rsid`"))
    
    if (!dir.exists(sub_dir)){
      dir.create(sub_dir)
    } else{
      print("dir exists!")
    }
    
    # Export text file of response into folder labeled with specified rsid
    sink(file.path(sub_dir, file_name))
    str(response)
    sink()
  }
}

# Sends POST request for Genotypes, Phenotypes, and Pop Genotypes to Ensembl for each RsID 
count = 158
for (rsid in variant_rsids[158: length(variant_rsids)]){
  if (grepl('chr', rsid, fixed = TRUE)){
    next
  }
  else{
    # Genotypes POST request
    genotypes_ext <- fn$identity("/variation/homo_sapiens/`rsid`?genotypes=1")
    POST_requests(genotypes_ext, rsid, "Ensembl_Genotypes_Response.txt")
    
    # Phenotypes POST request
    phenotypes_ext <- fn$identity("/variation/homo_sapiens/`rsid`?phenotypes=1")
    POST_requests(phenotypes_ext, rsid, "Ensembl_Phenotypes_Response.txt")
    
    # Population Genotypes POST request
    pop_genotypes_ext <- fn$identity("/variation/homo_sapiens/`rsid`?population_genotypes=1")
    POST_requests(pop_genotypes_ext, rsid, "Ensembl_Population_Genotypes_Response.txt")

    count = count + 1
    print(count)
  }
}

# Removes folders in GWAS_RsIDs that are empty 
for (sub_dir in consequence_terms){
  path = file.path(output_dir, sub_dir)
  if (length(list.files(path)) == 0){
    unlink(path, recursive = TRUE)
  }
}