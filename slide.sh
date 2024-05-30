#!/bin/bash
#SBATCH --job-name="SLIDEl_gpu"  
#SBATCH --time=5:00:00
#SBATCH --mail-user=swk25@pitt.edu
#SBATCH --mail-type=END,FAIL

module load gcc/12.2.0
module load r/4.3.0
Rscript /ix/djishnu/Swapnil/kaplanAnalysis/final_analysis/slide_analysis/slide_runs/runSLIDE.R