#!/bin/bash

set -euo pipefail

# Clone sarek repository at version 3.5.0
git clone -b 3.5.0 git@github.com:nf-core/sarek.git

# Copy relevant singularity images
cp -r /scratch/vp91/singularity sarek/