#!/bin/bash

## RUN THIS SCRIPT FROM THE Parabricks-Genomics-nf DIRECTORY WITH:
## qsub bin/run_script.sh

#PBS -P ad78
#PBS -q copyq
#PBS -l walltime=02:00:00
#PBS -lstorage=scratch/ad78
#PBS -l mem=5GB
#PBS -l ncpus=1

ref=/scratch/ad78/gs5517/nextflow-on-hpc-materials/data/ref/Homo_sapiens_assembly38.chr20-22.fasta
input=/scratch/ad78/gs5517/nextflow-on-hpc-materials/assets/parabricks-samplesheet.csv
gadi_account=er01
storage_account=ad78,er01

module load nextflow
module load singularity

nextflow run /scratch/ad78/gs5517/nextflow-on-hpc-materials/assets/Parabricks-Genomics-nf/main.nf \
    --ref ${ref} \
    --input ${input} \
    --cohort_name nf4hpc-workshop \
    --outdir /scratch/er01/gs5517/nf4hpc-workshop \
    --gadi_account ${gadi_account} \
    --storage_account ${storage_account} \
    --whoami $(whoami) \
    -profile gadi
