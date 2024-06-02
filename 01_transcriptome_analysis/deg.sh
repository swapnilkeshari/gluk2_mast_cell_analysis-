#!/bin/bash
#SBATCH -t 1-00:00 # Runtime in D-HH:MM
#SBATCH --job-name=sleuth_main
#SBATCH --mail-type=END,FAIL
##SBATCH --mail-user=swk25@pitt.edu

module purge
module load gcc/12.2.0
module load r/4.3.0
# Requires path to yaml as input as argument 1
Rscript /ix/djishnu/Swapnil/kaplanAnalysis/final_analysis/Youran/sleuth_deg.R $1
# Wrapper for pitt crc cluster. Remove if not running on pitt crc
crc-job-stats