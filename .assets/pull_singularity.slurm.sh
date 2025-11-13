#!/bin/bash
#SBATCH --account=pawsey1227
#SBATCH --job-name=fastqc
#SBATCH --partition=work
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=05:00:00

set -euo pipefail

module load singularity/4.1.0-slurm
SINGULARITY_CACHEDIR=/scratch/pawsey1227/training/nf4hpc/singularity
mkdir -p ${SINGULARITY_CACHEDIR}

singularity pull ${SINGULARITY_CACHEDIR}/quay.io-biocontainers-fastqc-0.12.1--hdfd78af_0.img docker://quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-mulled-v2-d9e7bad0f7fbc8f4458d5c3ab7ffaaf0235b59fb-7cc3d06cbf42e28c5e2ebfc7c858654c7340a9d5-0.img https://depot.galaxyproject.org/singularity/mulled-v2-d9e7bad0f7fbc8f4458d5c3ab7ffaaf0235b59fb:7cc3d06cbf42e28c5e2ebfc7c858654c7340a9d5-0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-htslib-1.20--h5efdd21_2.img https://depot.galaxyproject.org/singularity/htslib:1.20--h5efdd21_2
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-gatk4-4.5.0.0--py36hdfd78af_0.img https://depot.galaxyproject.org/singularity/gatk4:4.5.0.0--py36hdfd78af_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-multiqc-1.25.1--pyhdfd78af_0.img https://depot.galaxyproject.org/singularity/multiqc:1.25.1--pyhdfd78af_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-bwa-0.7.18--he4a0461_0.img https://depot.galaxyproject.org/singularity/bwa:0.7.18--he4a0461_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-fastp-0.23.4--h5f740d0_0.img https://depot.galaxyproject.org/singularity/fastp:0.23.4--h5f740d0_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-fastqc-0.12.1--hdfd78af_0.img https://depot.galaxyproject.org/singularity/fastqc:0.12.1--hdfd78af_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40-1bd8542a8a0b42e0981337910954371d0230828e-0.img https://depot.galaxyproject.org/singularity/mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40:1bd8542a8a0b42e0981337910954371d0230828e-0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-samtools-1.21--h50ea8bc_0.img https://depot.galaxyproject.org/singularity/samtools:1.21--h50ea8bc_0
singularity pull ${SINGULARITY_CACHEDIR}/quay.io-biocontainers-bcftools-1.22--h3a4d415_1.img docker://quay.io/biocontainers/bcftools:1.22--h3a4d415_1
singularity pull ${SINGULARITY_CACHEDIR}/quay.io-biocontainers-fastp-1.0.1--heae3180_0.img docker://quay.io/biocontainers/fastp:1.0.1--heae3180_0
singularity pull ${SINGULARITY_CACHEDIR}/quay.io-biocontainers-gatk4-4.6.2.0--py310hdfd78af_1.img docker://quay.io/biocontainers/gatk4:4.6.2.0--py310hdfd78af_1
singularity pull ${SINGULARITY_CACHEDIR}/quay.io-biocontainers-mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40-1bd8542a8a0b42e0981337910954371d0230828e-0.img docker://quay.io/biocontainers/mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40:1bd8542a8a0b42e0981337910954371d0230828e-0
singularity pull ${SINGULARITY_CACHEDIR}/quay.io-biocontainers-multiqc-1.19--pyhdfd78af_0.img docker://quay.io/biocontainers/multiqc:1.19--pyhdfd78af_0

cd $(dirname ${SINGULARITY_CACHEDIR})
tar -cvf singularity.tar singularity/
