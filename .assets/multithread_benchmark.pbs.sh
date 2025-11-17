#!/bin/bash
#PBS -P vp91
#PBS -N bwa_fqc
#PBS -q normalbw
#PBS -l ncpus=8
#PBS -l mem=1GB
#PBS -l walltime=00:10:00
#PBS -l storage=scratch/vp91
#PBS -l wd

module load bwa/0.7.17
module load fastqc

SAMPLE_ID="NA12878_chr20-22"
READS_1="../data/fqs/${SAMPLE_ID}.R1.fq.gz"
READS_2="../data/fqs/${SAMPLE_ID}.R2.fq.gz"

rm -f bwa_times.wall.txt
rm -f bwa_times.cpu.txt
rm -f fastqc_times.wall.txt
rm -f fastqc_times.cpu.txt

for NCPUS in 2 4 6 8
do
    for I in {1..10}
    do
        time ( bwa mem -t ${NCPUS} -o /dev/null ../data/ref/Hg38.subsetchr20-22.fasta ../data/fqs/NA12878_chr20-22.R1.fq.gz ../data/fqs/NA12878_chr20-22.R2.fq.gz > /dev/null 2> /dev/null ) 2> _bwa_time.txt
        printf "${NCPUS}\t" >> bwa_times.wall.txt
        printf "${NCPUS}\t" >> bwa_times.cpu.txt
        grep real _bwa_time.txt | sed -E -e 's/^\w+\s+//g' -e 's/^[0-9]+m//g' -e 's/s$//g' >> bwa_times.wall.txt
        grep user _bwa_time.txt | sed -E -e 's/^\w+\s+//g' -e 's/^[0-9]+m//g' -e 's/s$//g' >> bwa_times.cpu.txt
        rm _bwa_time.txt
        time ( fastqc -t ${NCPUS} --outdir "results/fastqc_${SAMPLE_ID}_${NCPUS}_logs" --format fastq ${READS_1} ${READS_2} > /dev/null 2> /dev/null ) 2> _fqc_time.txt
        printf "${NCPUS}\t" >> fastqc_times.wall.txt
        printf "${NCPUS}\t" >> fastqc_times.cpu.txt
        grep real _fqc_time.txt | sed -E -e 's/^\w+\s+//g' -e 's/^[0-9]+m//g' -e 's/s$//g' >> fastqc_times.wall.txt
        grep user _fqc_time.txt | sed -E -e 's/^\w+\s+//g' -e 's/^[0-9]+m//g' -e 's/s$//g' >> fastqc_times.cpu.txt
        rm _fqc_time.txt
    done
done
