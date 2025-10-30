#!/bin/bash
#PBS -P er01
#PBS -l walltime=00:30:00
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -q copyq
#PBS -W umask=022
#PBS -l wd
#PBS -lstorage=scratch/ad78

## Description:
## 1. Subset hg38 reference to chr20–22
## 2. Split chr20 and chr21 into halves (chr20a/b, chr21a/b)
## 3. Concatenate into a small “training” FASTA
## 4. Run Nextflow index-reference-fasta-nf pipeline to build indexes

# ------------------------------
# Load modules
# ------------------------------
module load samtools
module load nextflow

# ------------------------------
# Environment setup
# ------------------------------
cache="/scratch/ad78/mb0076/singularity"
export SINGULARITY_CACHEDIR=${cache}
export NXF_SINGULARITY_CACHEDIR=${cache}

# ------------------------------
# Paths
# ------------------------------
# ref_full=/scratch/ad78/gs5517/nextflow-on-hpc-materials/data/Homo_sapiens_assembly38.fasta
datadir=/scratch/ad78/gs5517/nextflow-on-hpc-materials/data
ref_subset=${datadir}/ref/Homo_sapiens_assembly38.chr20-22.fasta
ref_tiny=${datadir}/Homo_sapiens_assembly38.training.fasta


# ------------------------------
# Step 1. Subset to chr20, chr21, chr22
# ------------------------------
echo "[INFO] Subsetting chr20–22..."
# samtools faidx $ref_full chr20 chr21 chr22 > $ref_subset

# ------------------------------
# Step 2. Split chr20/chr21 into halves
# ------------------------------
echo "[INFO] Splitting chr20/chr21 into halves..."
# samtools faidx $ref_subset

chr20_len=$(awk '$1=="chr20"{print $2}' "${ref_subset}.fai")
chr21_len=$(awk '$1=="chr21"{print $2}' "${ref_subset}.fai")
chr22_len=$(awk '$1=="chr22"{print $2}' "${ref_subset}.fai")
half20=$(( chr20_len / 4 ))
half21=$(( chr21_len / 4 ))
half22=$(( chr22_len / 2 ))

# chr20 first quart
samtools faidx "$ref_subset" "chr20:1-${half20}" \
  | sed '1s/^>.*/>chr20/' > ${datadir}/chr20a.fa

# chr21 first quart
samtools faidx "$ref_subset" "chr21:1-${half21}" \
  | sed '1s/^>.*/>chr21/' > ${datadir}/chr21a.fa

# chr22 first half
samtools faidx "$ref_subset" "chr22:1-${half22}" \
  | sed '1s/^>.*/>chr22/' > ${datadir}/chr22a.fa

# ------------------------------
# Step 3. Concatenate mini FASTA
# ------------------------------
echo "[INFO] Creating tiny training FASTA..."
cat ${datadir}/chr20a.fa ${datadir}/chr21a.fa ${datadir}/chr22a.fa > "$ref_tiny"

# Clean up intermediates
rm ${datadir}/chr20a.fa ${datadir}/chr21a.fa ${datadir}/chr22a.fa

# ------------------------------
# Step 4. Index the tiny reference with Nextflow
# ------------------------------
echo "[INFO] Running Nextflow indexing pipeline..."
nextflow run index-reference-fasta-nf/main.nf \
    --ref "$ref_tiny" \
    --bwa --gatk --samtools \
    -profile gadi \
    --whoami mb0076 \
    --gadi_account ad78

# ------------------------------
# Step 5. Report
# ------------------------------
echo "[INFO] Done. Contigs in training FASTA:"
cut -f1,2 "${ref_tiny}.fai"