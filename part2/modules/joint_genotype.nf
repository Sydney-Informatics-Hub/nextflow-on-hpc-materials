process JOINT_GENOTYPE {

    container "quay.io/biocontainers/gatk4:4.6.2.0--py310hdfd78af_1"
    publishDir "${params.outdir}/genotyping"

    input:
    tuple val(cohort_id), path(gvcfs), path(gvcfs_idx)
    tuple path(ref_fasta), path(ref_fai), path(ref_dict)

    output:
    tuple val(cohort_id), path("${cohort_id}.vcf.gz"), path("${cohort_id}.vcf.gz.tbi"), emit: vcf

    script:
    variant_params = gvcfs.collect { f -> "--variant ${f}" }.join(" ")
    """
    gatk --java-options "-Xmx4g" CombineGVCFs -R $ref_fasta $variant_params -O cohort.g.vcf.gz
    gatk --java-options "-Xmx4g" GenotypeGVCFs -R $ref_fasta -V cohort.g.vcf.gz -O cohort.vcf.gz
    """

}