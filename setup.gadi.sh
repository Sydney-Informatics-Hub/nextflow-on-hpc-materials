#!/bin/bash

set -euo pipefail

# Extract reference files
cd data/ref
tar -xzf Hg38.subsetchr20-22.tar.gz

# Pull sarek
cd ../../part1
git clone -b 3.5.0 https://github.com/nf-core/sarek.git

# Setup singularity cachedir
cd ..
cp -r /scratch/vp91/singularity .

echo "Setup complete"