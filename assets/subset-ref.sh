#!/bin/bash

#PBS -P ad78
#PBS -l walltime=00:30:00
#PBS -l ncpus=1
#PBS -l mem=10GB
#PBS -q copyq
#PBS -W umask=022
#PBS -l wd
#PBS -lstorage=scratch/ad78

## Assumes full reference fasta is saved to /scratch/ad78/gs5517/nextflow-on-hpc-materials/data
## Will save subset and indexes to same directory
## Run this script from the assets directory

# Load required modules
module load samtools
module load nextflow
module load singularity

#set env variable
cache="/scratch/ad78/mb0076/singularity"
export SINGULARITY_CACHEDIR=${cache}
export NXF_SINGULARITY_CACHEDIR=${cache}

# Paths
ref_full=/scratch/ad78/gs5517/nextflow-on-hpc-materials/data/Homo_sapiens_assembly38.fasta
ref_subset=/scratch/ad78/gs5517/nextflow-on-hpc-materials/data/Homo_sapiens_assembly38.chr20-22.fasta

# Subset reference to chr20, chr21, chr22
samtools faidx $ref_full chr20 chr21 chr22 > $ref_subset

# Index the subset reference using Nextflow pipeline
nextflow run index-reference-fasta-nf/main.nf \
    --ref $ref_subset \
    --bwa --gatk --samtools \
    -profile gadi \
    --whoami mb0076 \
    --gadi_account ad78
