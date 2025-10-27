# For trainers 

These scripts were used to prepare input and reference data. Data was prepared on NCI Gadi, scirpts are written accordingly. 

## Download PG samples 

In this workshop we have used samples from the Platinum Genomes short read sequencing dataset.

Download the samples using Illumina's Basespace CLI utility using: 

```
qsub download-pg.sh
```

Before running, install the Basespace CLI utility following details in the script header. 

## Download the reference 

For this workshop we used hg38 reference assembly to align fastq files and generate alignments and to subset fastq reads to chr 20-22. 

Download the reference assembly from the GATK resource bundle available on google cloud using 

```
bash download-ref.sh
```

## Index the reference 

Following download, we indexed for BWA-mem and GATK using the [index-reference-fasta-nf](https://github.com/Sydney-Informatics-Hub/index-reference-fasta-nf) pipeline. Run with: 

Download the codebase: 

```
git clone https://github.com/Sydney-Informatics-Hub/index-reference-fasta-nf.git
```

```
qsub index-ref.sh 
```

## Subset the reference 

We only used chromosomes 20-22 so subset the reference accordingly using: 

```
bash subset-ref.sh
```


