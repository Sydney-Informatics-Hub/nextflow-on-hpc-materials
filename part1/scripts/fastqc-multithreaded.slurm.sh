#!/bin/bash
#SBATCH --account=courses01
#SBATCH --job-name=fastqc
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=1GB
#SBATCH --time=00:02:00

module load fastqc/0.11.9--hdfd78af_1

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