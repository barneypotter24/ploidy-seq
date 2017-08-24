#!/bin/bash

# Create conda environment and install important programs
conda create -n ploidy-seq -c bioconda python=3
conda install -n ploidy-seq -c bioconda trimmomatic=0.36
conda install -n ploidy-seq -c bioconda fastqc=0.11.5
conda install -n ploidy-seq -c conda-forge perl=5.22.0.1
conda install -n ploidy-seq -c bioconda hisat2=2.1.0
conda install -n ploidy-seq -c bioconda cufflinks=2.2.1
conda install -n ploidy-seq -c bioconda htseq=0.7.2

source activate ploidy-seq && pip install snakemake

# # Make directories that will store input and reference data
mkdir reference
mkdir fastq

# Make directories for intermediary and output files
mkdir trimmo
mkdir fastqc
mkdir gztmp
mkdir hisat2
mkdir cufflinks
mkdir htseq

# Populate data directories from CyVerse cloud

# Arabidopsis reference genome
cd reference && iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR10.gene_exons.gtf
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR10_spliceSites.txt
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.1.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.2.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.3.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.4.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.5.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.6.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.7.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.8.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/Athaliana_167_TAIR9.fa.gz
# ERCC reference 'genome'
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.1.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.2.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.3.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.4.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.5.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.6.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.7.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.8.ht2
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.fa
iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/ERCC92.gtf
# FastQ transcriptome files
cd ../fastq && iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/2WL1_CAGATC_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/2WL2_CAGATC_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/2WL3_ATCACG_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/2WL4_CAGATC_R1.fastq.gz

iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/4WL1_CGATGT_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/4WL2_TTAGGC_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/4WL3_CCGTCC_R1.fastq.gz

iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48974_CA73UANXX_2xWa5_CCGTCC_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48975_CA73UANXX_2xWa6_GTCCGC_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48976_CA73UANXX_2xWa7_GTGAAA_R1.fastq.gz

iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48977_CA73UANXX_4xWa4_GTGGCC_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48978_CA73UANXX_4xWa5_GTTTCG_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48979_CA73UANXX_4xWa6_CGTACG_R1.fastq.gz
iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/8204_1401_48980_CA73UANXX_4xWa7_GAGTGG_R1.fastq.gz
