# Post-GWAS Variant Analysis Automation
Project done through INFO-B 536: Computational Methods for Bioiformatics. 

**Fall 2022** <br/>
**Programming Language:** R <br/>
**Background:**<br/>
Program aims to develop an automated pipeline to link variants from Genome Wide Association Studies (GWAS) results to associated genes, in order to create a collated folder of resources for further functional analysis. For purposes of demonstration, we will be using Crohn’s Disease (CD) as an example to illustrate pipeline functionality. CD was chosen as an example as it exhibits the problems seen in applying GWAS results, as the sufficient catalog of verified risk variant mechanisms only has value through post-GWAS analysis. 

**Description:** The shell script takes in a user inputted EFO ID and runs subsequent R files to curate a folder of variation features for the GWAS RsIDs associated with that EFO ID

<b> Files: </b><br>
Pipeline.sh -> Linux file that runs R files in sequential order using user input <br>
Query_GWAS.R -> R file that queries GWAS API to get variant RsIDs for inputted EFO ID <br>
Filter_Variant_IDs.R -> R file that filters resulting RsIDs from Query_GWAS.R <br>
Query_Ensembl.R -> R file that queries Ensembl API for each RsID from Filter_Variant_IDs.R <br>

<b> Execution:</b>
1. Open Terminal
2. Change working directory to location of files
  	cd path/to/files
  	Example: cd Downloads
3. Ensure required files are in your working directory
4. Run the following command in your terminal to ensure R is installed in your machine
    brew install r
5. Run the following commands in your terminal to make scripts executable
  	chmod +x Pipeline.sh 
  	chmod +x Query_GWAS.R
  	chmod +x Filter_Variant_IDs.R 
  	chmod +x Query_Ensembl.R 
6. Run the following command in your terminal to create variable for EFO ID of interest
    export gwas_efo_id="EFO_ID"
    Example: gwas_efo_id="EFO_0000384"
7. Run the following command to run the shell script
    ./Pipeline.sh
8. Once execution is complete check output in your directory 

<b> Output files: </b><br>
<li>GWAS_Variant_IDs.txt<br>
<li>GWAS_Filtered_Variant_IDs.txt<br>

Main Folder: <br>
<li>GWAS_RsIDs<br>
Subfolders (Some may be removed throughout program: <br>
    <li> sequence_variant<br>
    <li> regulatory_region_variant<br>
    <li> feature_elongation<br>
    <li> intron_variant<br>
    <li> transcript_ablation<br>
    <li> transcript_amplification<br>
    <li> TFBS_ablation<br>
    <li> stop_retained_variant<br>
    <li> coding_sequence_variant<br>
    <li>stop_gained<br>
    <li>regulatory_region_ablation<br>
    <li>inframe_insertion<br>
    <li>TF_binding_site_variant<br>
    <li>NMD_transcript_variant<br>
    <li>splice_donor_5th_base_variant<br>
    <li>start_retained_variant<br>
    <li>splice_donor_region_variant<br>
    <li>TFBS_amplification<br>
    <li>missense_variant<br>
    <li>downstream_gene_variant<br>
    <li>splice_acceptor_variant<br>
    <li>protein_altering_variant<br>
    <li>non_coding_transcript_variant<br>
    <li>inframe_deletion<br>
    <li>splice_polypyrimidine_tract_variant<br>
    <li>5_prime_UTR_variant<br>
    <li>regulatory_region_amplification<br>
    <li>start_lost<br>
    <li>frameshift_variant<br>
    <li>feature_truncation<br>
    <li>synonymous_variant<br>
    <li>incomplete_terminal_codon_variant<br>
    <li>mature_miRNA_variant<br>
    <li>non_coding_transcript_exon_variant<br>
    <li>upstream_gene_variant<br>
    <li>splice_region_variant<br>
    <li>splice_donor_variant<br>
    <li>3_prime_UTR_variant<br>
    <li>stop_lost<br>
    <li>intergenic_variant<br>
    Subfolders:<br>
      <li>RsID labeled folders<br>
        Subfolders:<br>
          <li>Ensembl_Genotypes_Response.txt<br>
          <li>Ensembl_Phenotypes_Response.txt<br>
          <li>Ensembl_Population_Genotypes_Response.txt<br>
