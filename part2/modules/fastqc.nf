process FASTQC {

    tag "fastqc on ${sample_id}"
    container "quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0"
    publishDir "${params.outdir}/fastqc", mode: 'copy'

    input:
    tuple val(sample_id), path(reads_1), path(reads_2)

    output:
    path "fastqc_${sample_id}", emit: qc_out

    script:
    """
    mkdir -p "fastqc_${sample_id}"
    fastqc -t $task.cpus --outdir "fastqc_${sample_id}" --format fastq $reads_1 $reads_2
    """

}