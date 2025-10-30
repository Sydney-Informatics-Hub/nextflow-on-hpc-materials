# Nextflow on HPC workshop materials 

This repository contains input and reference datasets to be used in the 2025 Nextflow on HPC workshop. 

## For partiticpants 

TODO add instructions for participants to download data in the workshop.

## For contributors 

See `assets/` for all scripts and instructions used to prepare data for this workshop. Instuctions are provided in `[assets/README.md](assets/README.md)`. 

Main branch is protected. No changes can be made without a PR and approval from another team member. 

### Reference data

We've used Hg38 chromosomes 20-22 (subset to first 1/4 of each) for the reference dataset. Indexes for bwa, samtools, gatk provided. Fasta and index files are provided in a gzipped tarball.

### Input data 

We've provided fastq and bam files for 3 [Platinum Genome](https://sapac.illumina.com/platinumgenomes.html) samples. Data is illumina short reads. We subset data to chromosomes 20-22.  