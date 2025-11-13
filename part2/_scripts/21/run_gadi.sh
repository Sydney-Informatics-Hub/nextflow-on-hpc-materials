#!/bin/bash

module load nextflow/24.04.5
module load singularity

nextflow run main.nf -profile pbspro --pbspro_account vp91 -c config/custom.config
