#!/bin/bash

ssh ${SETONIXUSER}@setonix.pawsey.org.au "cd /scratch/courses01/${SETONIXUSER}; git clone https://github.com/Sydney-Informatics-Hub/nextflow-on-hpc-materials.git; cd nextflow-on-hpc-materials; ./setup.setonix.sh"
