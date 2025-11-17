#!/bin/bash

module load nextflow/24.10.0
module load singularity/4.1.0-slurm

nextflow run main.nf -profile slurm --slurm_account courses01 -c config/custom.config
