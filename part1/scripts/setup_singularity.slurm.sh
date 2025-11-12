#!/bin/bash

set -euo pipefail

# Copy all the singularity images from the common project location to the local working directories

mkdir -p singularity
cp -r /scratch/courses01/singularity /scratch/${PAWSEY_PROJECT}/${USER}/nextflow-on-hpc-materials/
