process MERGE_BAMS {

    container "quay.io/biocontainers/mulled-v2-fe8faa35dbf6dc65a0f7f5d4ea12e31a79f73e40:1bd8542a8a0b42e0981337910954371d0230828e-0"
    publishDir "${params.outdir}/alignment"

    input:
    tuple val(sample_id), path(bams), path(bais)

    output:
    tuple val(sample_id), path("${sample_id}.bam"), path("${sample_id}.bam.bai"), emit: aligned_bam

    script:
    """
    samtools cat ${bams} | samtools sort -O bam -o ${sample_id}.bam
    samtools index ${sample_id}.bam
    """

}