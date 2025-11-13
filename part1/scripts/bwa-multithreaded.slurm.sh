#!/bin/bash
#SBATCH --account=courses01
#SBATCH --job-name=bwa
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=1GB
#SBATCH --time=00:02:00

module load bwa/0.7.17--h7132678_9

for NCPUS in 2 4 6 8
do
    echo "NCPUS: ${NCPUS}"
    time ( bwa mem -t ${NCPUS} -o /dev/null ../data/ref/Hg38.subsetchr20-22.fasta ../data/fqs/NA12878_chr20-22.R1.fq.gz ../data/fqs/NA12878_chr20-22.R2.fq.gz > /dev/null 2> /dev/null ) 2>&1
    echo "-----"
done > bwa_times.txt