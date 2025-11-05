#!/bin/bash
#PBS -P vp91
#PBS -N bwa
#PBS -q normalbw
#PBS -l ncpus=8
#PBS -l mem=1GB
#PBS -l walltime=00:10:00
#PBS -l storage=scratch/vp91
#PBS -l wd

module load bwa/0.7.17

for NCPUS in 2 4 6 8
do
    time ( bwa mem -t ${NCPUS} ../data/ref/Hg38.subsetchr20-22.fasta ../data/fqs/NA12878_chr20-22.R1.fq.gz ../data/fqs/NA12878_chr20-22.R2.fq.gz > alignment.${NCPUS}.sam ) >> bwa_times.txt
done
