process STATS {

    container "quay.io/biocontainers/bcftools:1.22--h3a4d415_1"
    publishDir "${params.outdir}/genotyping"

    input:
    tuple val(cohort_id), path(cohort_vcf), path(cohort_vcf_idx)

    output:
    path "bcftools_stats.txt", emit: stats_out

    script:
    """
    bcftools stats $cohort_vcf > bcftools_stats.txt
    """

}