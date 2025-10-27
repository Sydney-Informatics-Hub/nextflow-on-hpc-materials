#!/bin/bash

# This script was used to download Platinum Genomes fq files from Illumina's Basespace platform

#PBS -P ad78
#PBS -q copyq
#PBS -l walltime=02:00:00
#PBS -lstorage=scratch/ad78
#PBS -l mem=5GB
#PBS -l ncpus=1

## Run from assets directory
#qsub download-pg.sh

## BEFORE RUNNING, INSTALL BASESPACE CLI APP:
## wget "https://launch.basespace.illumina.com/CLI/latest/amd64-linux/bs" -O $HOME/bin/bs
## chmod u+x $HOME/bin/bs
## bs auth #go to auth link, accept terms and conditions

## Review usage memory with:
## bs list appsession

## List datasets available to you in BaseSpace (filtered to fq)
## bs list datasets --is-type=illumina.fastq.v1.8

## Copy list of IDs to config pg-bs.config

## Quick download
config=${PBS_O_WORKDIR}/pg-bs.config

mkdir -p ${PBS_O_WORKDIR}/../data/fqs
cat $config | while read line;
do
	bs download dataset -i $line --extension=fastq.gz -o ${PBS_O_WORKDIR}/../data/fqs
done
