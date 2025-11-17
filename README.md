# Nextflow on HPC workshop materials 

This repository contains input and reference datasets to be used in the 2025 Nextflow on HPC workshop. 

## For participants 

Setup and download instructions are available on the rendered documentation under [Setup the workspace](https://sydney-informatics-hub.github.io/nextflow-hpc-workshop/part1/01_0_intro/#102-setup-the-workspace)

## For contributors 

See `assets/` for all scripts and instructions used to prepare data for this workshop. Instuctions are provided in `[assets/README.md](assets/README.md)`. 

Main branch is protected. No changes can be made without a PR and approval from another team member. 

### Reference data

We've used Hg38 chromosomes 20-22 (subset to first 1/4 of each) for the reference dataset. Indexes for bwa, samtools, gatk provided. Fasta and index files are provided in a gzipped tarball.

### Input data 

We've provided fastq and bam files for 3 [Platinum Genome](https://sapac.illumina.com/platinumgenomes.html) samples. Data is illumina short reads. We subset data to chromosomes 20-22.  

### Part 2

The `part2/` folder contains all files in the correct structure to use at the
beginning of the workshop.
