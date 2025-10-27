#!/bin/bash

## Downloading hg38 from GATK resource bundle
## https://gatk.broadinstitute.org/hc/en-us/articles/360035890811-Resource-bundle
## https://console.cloud.google.com/storage/browser/genomics-public-data/resources/broad/hg38/v0;tab=objects?prefix=&forceOnObjectsSortingFiltering=false

module load singularity
module load nextflow

# Download fa
wget https://storage.googleapis.com/genomics-public-data/resources/broad/hg38/v0/Homo_sapiens_assembly38.fasta

# Index with samtools

# Subset to chr20-22


