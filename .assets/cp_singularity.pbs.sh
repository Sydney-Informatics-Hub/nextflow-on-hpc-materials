#!/bin/bash

DESTUSER="${1}"

set -euo pipefail

SOURCE=/scratch/ad78/training/nf4hpc/singularity.tar
DEST=/scratch/vp91/singularity.tar

scp ${SOURCE} ${DESTUSER}@localhost:${DEST}
