#!/bin/bash

ssh ${GADIUSER}@gadi.nci.org.au "cd /scratch/vp91/${GADIUSER}; git clone https://github.com/Sydney-Informatics-Hub/nextflow-on-hpc-materials.git; cd nextflow-on-hpc-materials; ./setup.gadi.sh" 