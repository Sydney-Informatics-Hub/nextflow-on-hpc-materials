#!/bin/bash

#PBS -P ad78
#PBS -l walltime=02:00:00
#PBS -l ncpus=1
#PBS -l mem=10GB
#PBS -q copyq
#PBS -W umask=022
#PBS -l wd
#PBS -lstorage=scratch/ad78

## Assumes reference fasta is saved to /scratch/ad78/gs5517/nextflow-on-hpc-materials/data
## Will save indexes to same directory
## Run this script from the assets directory

ref=/scratch/ad78/gs5517/nextflow-on-hpc-materials/data/Homo_sapiens_assembly38.fasta

module load nextflow
module load singularity

nextflow run index-reference-fasta-nf/main.nf \
	--ref $ref \
	--bwa --gatk --samtools \
	-profile gadi \
	--whoami gs5517 \
	--gadi_account ad78


