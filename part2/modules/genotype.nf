process GENOTYPE {

    container "quay.io/biocontainers/gatk4:4.6.2.0--py310hdfd78af_1"
    publishDir "${params.outdir}/genotyping"

    input:
    tuple val(sample_id), path(bam), path(bai)
    tuple path(ref_fasta), path(ref_fai), path(ref_dict)

    output:
    tuple val(sample_id), path("${sample_id}.g.vcf.gz"), path("${sample_id}.g.vcf.gz.tbi"), emit: gvcf

    script:
    """
    gatk --java-options "-Xmx4g" HaplotypeCaller -R $ref_fasta -I $bam -O ${sample_id}.g.vcf.gz -ERC GVCF
    """

}