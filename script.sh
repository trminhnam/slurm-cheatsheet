#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --job-name=run
#SBATCH --output=log.out
#SBATCH --error=log.out
#SBATCH --gres=gpu:1
#SBATCH --nodelist=gpu03
#SBATCH --cpus-per-task=12


nvidia-smi

python -c 'import torch; print(torch.cuda.is_available())'

python check.py