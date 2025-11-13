#!/bin/bash
#PBS -P vp91
#PBS -N fastqc
#PBS -q normalbw
#PBS -l ncpus=8
#PBS -l mem=1GB
#PBS -l walltime=00:02:00
#PBS -l storage=scratch/vp91
#PBS -l wd

module load fastqc

SAMPLE_ID="NA12878_chr20-22"
READS_1="../data/fqs/${SAMPLE_ID}.R1.fq.gz"
READS_2="../data/fqs/${SAMPLE_ID}.R2.fq.gz"

for NCPUS in 2 4 6 8
do
    mkdir -p "results/fastqc_${SAMPLE_ID}_${NCPUS}_logs"
    echo "NCPUS: ${NCPUS}"
    time ( fastqc -t ${NCPUS} --outdir "results/fastqc_${SAMPLE_ID}_${NCPUS}_logs" --format fastq ${READS_1} ${READS_2} > /dev/null 2> /dev/null ) 2>&1
    echo "-----"
done > fastqc_times.txt