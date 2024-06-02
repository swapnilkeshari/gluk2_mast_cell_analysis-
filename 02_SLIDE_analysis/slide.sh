#!/bin/bash
#SBATCH --job-name="SLIDE"  
#SBATCH --time=1-00:00:00
#SBATCH --mail-user=swk25@pitt.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --cluster=htc
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --mem=512g
#SBATCH --cpus-per-task=32

module load gcc/12.2.0
module load r/4.3.0
Rscript 02_runSLIDE.R "./slide.yaml"