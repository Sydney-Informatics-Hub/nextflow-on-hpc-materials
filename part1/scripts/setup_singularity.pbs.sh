#!/bin/bash

set -euo pipefail

# Copy all the singularity images from the common project location to the local working directories

mkdir -p singularity
cp /scratch/vp91/singularity/*.sif singularity/
