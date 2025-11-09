#!/bin/bash

module load nextflow/24.04.5
module load singularity

nextflow run sarek/main.nf \
    --input ../data/bams/samplesheet.csv \
    --step markduplicates \
    --skip_tools baserecalibrator,mosdepth,samtools \
    --outdir results \
    --no_intervals true \
    --fasta ../data/ref/Hg38.subsetchr20-22.fasta \
    --fasta_fai ../data/ref/Hg38.subsetchr20-22.fasta.fai \
    --igenomes_ignore true \
    -c config/gadi.config,config/custom.config \
    -resume
