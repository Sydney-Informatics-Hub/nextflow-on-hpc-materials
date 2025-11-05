process SPLIT_FASTQ {

    tag "split fastqs for ${sample_id}"
    container "quay.io/biocontainers/fastp:1.0.1--heae3180_0"

    input:
    tuple val(sample_id), path(reads_1), path(reads_2), val(n)

    output:
    tuple val(sample_id), path("*.${sample_id}.R1.fq"), path("*.${sample_id}.R2.fq"), emit: split_fq

    script:
    """
    fastp -Q -L -A -i $reads_1 -I $reads_2 -o ${sample_id}.R1.fq -O ${sample_id}.R2.fq -s $n
    """

}