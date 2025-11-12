#!/bin/bash

set -euo pipefail

# Extract reference files
cd data/ref
tar -xzf Hg38.subsetchr20-22.tar.gz

# Pull sarek
cd ../../part1
git clone -b 3.5.0 https://github.com/nf-core/sarek.git
git clone https://github.com/Sydney-Informatics-Hub/config-demo-nf.git

# Setup singularity cachedir
cd ..
cp /scratch/vp91/singularity.tar .
tar -xf singularity.tar

echo "Setup complete"