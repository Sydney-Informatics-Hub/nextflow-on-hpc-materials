#!/bin/bash
#PBS -P er01
#PBS -l walltime=01:00:00
#PBS -l ncpus=1
#PBS -l mem=10GB
#PBS -q normal
#PBS -W umask=022
#PBS -l wd
#PBS -lstorage=scratch/ad78

###############################################################################
# bam_to_fastq_subset.pbs
#
# Subsample BAM files to ≤1500 paired reads, produce:
#   - Subset BAMs (*.subset.bam + index)
#   - Paired FASTQ files (*.R1.fq.gz / *.R2.fq.gz)
#
# Works on all PBS variants (Torque, PBS Pro, OpenPBS).
#
# Example submissions:
#   qsub -v ARGS="-r -f bam_list.txt" /path/to/subset-bam.sh
#   qsub -v ARGS="-r" /path/to/subset-bam.sh
#   qsub -v ARGS="sample1.bam sample2.bam" /path/to/subset-bam.sh
#
###############################################################################

# --- environment setup ---
module load samtools
set -euo pipefail

# --- reconstruct args from PBS -v ARGS ---
if [[ -n "${ARGS:-}" ]]; then
  echo "[INFO] Received ARGS from PBS: $ARGS"
  eval set -- "$ARGS"
fi

# --- configuration ---
WORKDIR="/scratch/ad78/gs5517/nextflow-on-hpc-materials/data"
NREADS=1500  # number of read pairs to retain
SCRATCH_TMP="$WORKDIR/tmp_${PBS_JOBID}"
mkdir -p "$SCRATCH_TMP"
trap "rm -rf $SCRATCH_TMP" EXIT

echo "[INFO] Starting BAM subset job at $(date)"
echo "[INFO] Working directory: $WORKDIR"
echo "[INFO] Temporary work dir: $SCRATCH_TMP"
echo "[INFO] Using $(samtools --version | head -n1)"

cd "$WORKDIR"

# --- parse arguments ---
RANDOM_SAMPLE=false
BAMFILES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -r) RANDOM_SAMPLE=true; shift ;;
    -f)
      [[ -f "$2" ]] || { echo "[ERROR] BAM list file '$2' not found"; exit 1; }
      mapfile -t BAMFILES < "$2"
      shift 2
      ;;
    *) BAMFILES+=("$1"); shift ;;
  esac
done

# Default to all BAMs in directory if none specified
if [[ ${#BAMFILES[@]} -eq 0 ]]; then
  shopt -s nullglob
  BAMFILES=(*.bam)
fi

[[ ${#BAMFILES[@]} -gt 0 ]] || { echo "[ERROR] No BAM files found."; exit 1; }

# --- main processing loop ---
for bam in "${BAMFILES[@]}"; do
  [[ -f "$bam" ]] || { echo "[WARN] Skipping missing file: $bam"; continue; }

  prefix=$(basename "${bam%.bam}")
  tmpnames="$SCRATCH_TMP/${prefix}_names.txt"
  subsetbam="${prefix}.subset.bam"

  echo "[INFO] Processing $bam → $subsetbam / ${prefix}.R1.fq.gz / ${prefix}.R2.fq.gz"

  # --- extract read names ---
  if $RANDOM_SAMPLE; then
    samtools view -f 0x2 "$bam" | \
      awk '{print $1}' | sed 's/\/[12]$//' | sort -u | \
      shuf -n "$NREADS" > "$tmpnames"
  else
    samtools view -f 0x2 "$bam" | \
      awk '{print $1}' | sed 's/\/[12]$//' | \
      awk '!seen[$1]++' | head -n "$NREADS" > "$tmpnames"
  fi

  # --- create subset BAM ---
  samtools view -b -N "$tmpnames" "$bam" -o "$SCRATCH_TMP/${prefix}.subset.tmp.bam"
  samtools sort -o "$subsetbam" "$SCRATCH_TMP/${prefix}.subset.tmp.bam"
  samtools index "$subsetbam"
  rm -f "$SCRATCH_TMP/${prefix}.subset.tmp.bam"

  # --- convert to FASTQ ---
  samtools fastq \
    -1 >(gzip -c > "${prefix}.R1.fq.gz") \
    -2 >(gzip -c > "${prefix}.R2.fq.gz") \
    -0 /dev/null \
    -s /dev/null \
    -n \
    "$subsetbam"

  # --- report read counts ---
  r1count=$(($(zcat "${prefix}.R1.fq.gz" | wc -l) / 4))
  r2count=$(($(zcat "${prefix}.R2.fq.gz" | wc -l) / 4))
  echo "[INFO]   R1 reads: $r1count, R2 reads: $r2count"

  rm -f "$tmpnames"
done

echo "[DONE] All BAMs processed successfully at $(date)"