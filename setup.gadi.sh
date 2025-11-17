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

# Fix potential issues with default project
set +e
PROJISVP91=$(grep -c "^PROJECT.*vp91$" ~/.config/gadi-login.conf)
set -e
if [ "${PROJISVP91}" == "0" ]
then
    sed -i -e "s/\(PROJECT \)\w*/\1vp91/" ~/.config/gadi-login.conf
    echo "IMPORTANT: YOUR DEFAULT PROJECT HAS BEEN CHANGED TO 'vp91'. PLEASE LOG OUT AND BACK IN AGAIN TO REFRESH YOUR SESSION."
fi

echo "Setup complete"