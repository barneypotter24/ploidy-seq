#!/bin/bash

# Install miniconda
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# bash Miniconda3-latest-Linux-x86_64.sh
# source ~/.bash_profile

# Create conda environment and install important programs
conda create -n ploidy-seq -c bioconda python=3
conda install -n ploidy-seq -c bioconda trimmomatic=0.36
conda install -n ploidy-seq -c bioconda fastqc=0.11.5
conda install -n ploidy-seq -c bioconda hisat2=2.1.0
conda install -n ploidy-seq -c bioconda cufflinks=2.2.1
conda install -n ploidy-seq -c bioconda htseq=0.7.2

source activate ploidy-seq && pip install snakemake

# Make directories that will store input and reference data
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
# cd reference && iget -K /iplant/home/jcoate/Arabidopsis/2017/Reference_Seqs/*
# cd fastq && iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/2WL*
# cd fastq && iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/4WL*
# cd fastq && iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/*2xWa*
# cd fastq && iget -K /iplant/home/jcoate/Arabidopsis/2017/Fastq/*4xWa*
