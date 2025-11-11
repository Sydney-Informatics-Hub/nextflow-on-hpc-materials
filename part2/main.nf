include { FASTQC } from './modules/fastqc'
include { ALIGN } from './modules/align'
include { GENOTYPE } from './modules/genotype'
include { JOINT_GENOTYPE } from './modules/joint_genotype'
include { STATS } from './modules/stats'
include { MULTIQC } from './modules/multiqc'

// Define the workflow
workflow {

    // Define the fastqc input channel
    reads = Channel.fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row -> {
            // def strandedness = row.strandedness ? row.strandedness : 'auto'
            [ row.sample, file(row.fastq_1), file(row.fastq_2) ] 
        }}

    bwa_index = Channel.fromPath(params.bwa_index)
        .map { idx -> [ params.bwa_index_name, idx ] }
    ref = Channel.of( [ file(params.ref_fasta), file(params.ref_fai), file(params.ref_dict) ] )

    // Run the fastqc step with the reads_in channel
    FASTQC(reads)

    // Run the align step with the reads_in channel and the genome reference
    ALIGN(reads, bwa_index)

    // Run genotyping with aligned bam and genome reference
    GENOTYPE(ALIGN.out.aligned_bam, ref)

    // Gather gvcfs and run joint genotyping
    all_gvcfs = GENOTYPE.out.gvcf
        .map { _sample_id, gvcf, gvcf_idx -> [ params.cohort_name, gvcf, gvcf_idx ] }
        .groupTuple()
    JOINT_GENOTYPE(all_gvcfs, ref)

    // Get VCF stats
    STATS(JOINT_GENOTYPE.out.vcf)

    // Collect summary data for MultiQC
    multiqc_in = FASTQC.out.qc_out
        .mix(STATS.out.stats_out)
        .collect()

    /*
    * Generate the analysis report with the 
    * outputs from fastqc and bcftools stats
    */ 
    MULTIQC(multiqc_in)

}
