#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --job-name=setup
#SBATCH --output=log.out
#SBATCH --error=log.err
#SBATCH --gres=gpu:4
#SBATCH --nodelist=gpu02


huggingface-cli login --token 