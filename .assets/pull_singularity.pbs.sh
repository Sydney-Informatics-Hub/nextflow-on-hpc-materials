module load singularity
SINGULARITY_CACHEDIR=/scratch/vp91/singularity
mkdir ${SINGULARITY_CACHEDIR}

singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-mulled-v2-d9e7bad0f7fbc8f4458d5c3ab7ffaaf0235b59fb-7cc3d06cbf42e28c5e2ebfc7c858654c7340a9d5-0.img https://depot.galaxyproject.org/singularity/mulled-v2-d9e7bad0f7fbc8f4458d5c3ab7ffaaf0235b59fb:7cc3d06cbf42e28c5e2ebfc7c858654c7340a9d5-0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-htslib-1.20--h5efdd21_2.img https://depot.galaxyproject.org/singularity/htslib:1.20--h5efdd21_2
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-gatk4-4.5.0.0--py36hdfd78af_0.img https://depot.galaxyproject.org/singularity/gatk4:4.5.0.0--py36hdfd78af_0
singularity pull ${SINGULARITY_CACHEDIR}/depot.galaxyproject.org-singularity-multiqc-1.25.1--pyhdfd78af_0.img https://depot.galaxyproject.org/singularity/multiqc:1.25.1--pyhdfd78af_0