#!/bin/bash

module load nextflow
module load singularity

nextflow run sarek/main.nf \
    --input ../data/fqs/samplesheet.fq.csv \
    --step mapping \
    --skip_tools markduplicates,baserecalibrator,mosdepth,samtools \
    --outdir results \
    --no_intervals true \
    --bwa ../data/ref \
    --fasta ../data/ref/Hg38.subsetchr20-22.fasta \
    --fasta_fai ../data/ref/Hg38.subsetchr20-22.fasta.fai \
    --igenomes_ignore true \
    -c config/gadi.config,config/custom.config \
    -resume
