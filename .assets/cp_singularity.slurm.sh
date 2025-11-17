#!/bin/bash

DESTUSER="${1}"

set -euo pipefail

SOURCE=/scratch/pawsey1227/training/nf4hpc/singularity.tar
DEST=/scratch/courses01/singularity.tar

scp ${SOURCE} ${DESTUSER}@localhost:${DEST}
