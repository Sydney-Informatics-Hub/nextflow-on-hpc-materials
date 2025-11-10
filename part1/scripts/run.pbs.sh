#!/bin/bash

module load nextflow/24.04.5
module load singularity

nextflow run sarek/main.nf \
    --input ../data/fqs/samplesheet.single.csv \
    --fasta ../data/ref/Hg38.subsetchr20-22.fasta \
    --fasta_fai ../data/ref/Hg38.subsetchr20-22.fasta.fai \
    --dict ../data/ref/Hg38.subsetchr20-22.dict \
    --bwa ../data/ref \
    --step mapping \
    --skip_tools markduplicates,baserecalibrator,mosdepth,samtools \
    --outdir results \
    --no_intervals true \
    --igenomes_ignore true \
    -c config/gadi.config,config/custom.config \
    -resume
